# Running MP1 with Docker
This should be about as plug and play as it gets for people running on a Mac M-processor.

## Prerequisites
1. `docker` is installed on your computer and command line.
0. Docker Desktop (suggested to easier access files written into the volume)

## Repo setup
This repo contains the `code` folder and `Dockerfile` in the appropriate locations. 

### Clone Repo

    git clone <repo>

> [!NOTE] 
> This repo's `main.py` redirects the `indexes/`, `processed_corpus/` and `results_<dataset>.json` to `output/` for the docker volume. These changes must be in place to work. 

### Download Data
It is **necessary** to download the `data` folder from the [MP1 warmup](https://www.coursera.org/learn/cs-410/supplement/vc0jm/programming-assignment-1-warmup) on Coursera and put it inside the `code/` folder.

```
MP1
│   README.md
│   Dockerfile    
│
└───code
│   │   instructions.md
│   │   main.py
│   │
│   └───data
│       └───apnews
│       └───cranfield
│       └───new_faculty
```

### Create Volume
Create a volume to see the `main.py` output files/folders.

    docker volume create mp1-volume


## Running the Project
All these commands are run from your terminal.

> [!WARNING]
> I am using `--platform linux/amd64` in my docker commands and `Dockerfile`. This may need to change if you are not using a Mac M-processor.

### Build Image
This needs to be done every time there are changes to `main.py`

    docker build --platform linux/amd64 -t mp1-image .

> [!WARNING]
> This can take a few minutes (approx. 10 - 30 mins) to run the first time. Afterward, building should be instantaneous.

### Run Image
All the `main.py` printouts will show up on your terminal.

    docker run --platform linux/amd64 -it --rm -v mp1-volume:/app/output mp1-image

