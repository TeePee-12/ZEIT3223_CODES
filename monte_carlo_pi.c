/*
  Written by Edwin Peters
  for ZEIT 3223 Embedded Systems
  2023 
 */

#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h>  // header file for sleep(). man 3 sleep for details. 
#include <pthread.h> // header file for threading
#include <malloc.h> // header file for dynamic memory
#include <math.h>  // header file for math
#include <time.h> // to measure the time


#define SEED 1234324 // random seed

// Structure to store the data that is sent to each thread
typedef struct {
  pthread_t thread_id;
  unsigned int idx;
  unsigned int n_iter;
  unsigned int *out_data;
  unsigned int seed;
} thread_data_t;


void *compute_pi(void *vargp)
{
  /*
    This function computes pi. We can spawn multiple threads with this
   */
  
  thread_data_t *mydata = (thread_data_t *) vargp;
  
  unsigned int my_index = mydata->idx;
  unsigned int n_iter = mydata->n_iter;

  unsigned int seed = mydata->seed;
  
  printf("Thread index %d computing %d iterations, seed %d\n",my_index,n_iter,seed);
  double x,y;
  double z, pi;

  int count = 0;
  /* srand(mydata->seed); */
  for (int i = 0; i < n_iter; i++)
  {
      
    x = (double)rand_r(&seed)/RAND_MAX;
    y = (double)rand_r(&seed)/RAND_MAX;
    z = x*x+y*y;
    if (z<=1) count++;
  }
  printf("Thread index %d counted %d\n",my_index,count);
  *(mydata->out_data) = count; // store the output

  return NULL;
}



int main()
{
  clock_t c_start, c_end; // for CPU time
  time_t t_start, t_end; // for wall time

  int total_iter = 300000000; // the number of iterations that we want to simulate over

  int n_threads = 1;   // This sets the number of threads to be spawned 
  
  int n_iter = total_iter/n_threads; // iterations per thread


  printf("Computing the value of pi using %d threads\n", n_threads);
  
  // allocate memory
  unsigned int *n_count;
  n_count = malloc(n_threads*sizeof(unsigned int));  
  if (n_count == NULL)
  {
    printf("Malloc failed\n");
    exit(-1);
  }

  thread_data_t *thread_data = malloc(n_threads*sizeof(thread_data_t));
  if (thread_data == NULL)
  {
    printf("Malloc failed\n");
    exit(-1);
  }

  // we want to make the threads joinable. This causes our pthread_join function to wait until the threads are finished
  pthread_attr_t attr;

  // make the thread joinable
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_JOINABLE);

  // Spawn the threads
  int rc;
  c_start = clock();
  time(&t_start);
  for (int i = 0; i < n_threads; i++)
  {
    thread_data[i].idx = i;
    thread_data[i].n_iter = n_iter;
    thread_data[i].out_data = &n_count[i];
    thread_data[i].seed = SEED + i;
    rc = pthread_create(&thread_data[i].thread_id, &attr, compute_pi, (void *) &thread_data[i]);
    if (rc)
    {
      printf("Error making thread %d, return code %d\n",i,rc);
      exit(-1);
    }
  }

  // we can free the attributes now
  pthread_attr_destroy(&attr);
  // Wait for the threads to finish and join them
  for (int i = 0; i < n_threads; i++)
  {
    rc = pthread_join(thread_data[i].thread_id, NULL);
    if (rc)
    {
      printf("Error joining thread %d\n",i);
      exit(-1);
    }
  }

  // collate the sums
  unsigned int sum = 0;
  
  printf("results: ");
  for (int i = 0; i < n_threads; i++)
  {
    printf("%d, ", n_count[i]);
    sum += n_count[i];
  }
  printf("\n");

  // estimate pi
  double pi_est = (double) sum / (n_iter*n_threads)*4;
  c_end = clock();
  time(&t_end);

  printf("Estimated pi to %f\n",pi_est);

  double cpu_time = ((double)c_end-c_start)/CLOCKS_PER_SEC;
  double wall_time = (double)(t_end - t_start);
  printf("Wall time %f seconds, cpu time %f seconds\n", wall_time, cpu_time);

  // clear up our memory
  free(n_count);
  free(thread_data);
  
  exit(0);
}
