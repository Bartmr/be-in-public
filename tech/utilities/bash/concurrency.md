## Using `sleep`

Anytime a job finishes, a new one starts.

```bash
MAX_JOBS=2

for item in *; do
  
    # Wait until there are less than MAX_JOBS jobs running
    while [ $(jobs -rp | wc -l) -ge "$MAX_JOBS" ]; do
      sleep 0.5
    done

    command "$item" &

done

wait
```

## Using `wait`

All jobs in a chunk must end in order for the next chunk of jobs to start

```bash
MAX_JOBS=2

for item in *; do
  
    # Wait until there are less than MAX_JOBS jobs running
    while [ $(jobs -rp | wc -l) -ge "$MAX_JOBS" ]; do
      wait
    done

    command "$item" &

done

wait
```