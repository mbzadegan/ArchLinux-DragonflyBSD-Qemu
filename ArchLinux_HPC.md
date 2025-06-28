# Preparing Bare Installed Arch-Linux for HPC and Multi-thread Programming

This guide provides the steps to configure your Arch Linux system for high-performance computation (HPC) and multi-thread programming.

## Step 1: Update System
```bash
sudo pacman -Syu
```
Ensure all installed packages are up-to-date.

---

## Step 2: Install Essential Development Tools
Install the necessary compilers, libraries, and development tools:
```bash
sudo pacman -S base-devel gcc clang cmake make git
```

---

## Step 3: Configure Parallel Computing Libraries

### OpenMPI
Install and configure OpenMPI for distributed computing:
```bash
sudo pacman -S openmpi
```
Add OpenMPI paths to your environment:
```bash
echo 'export PATH=/usr/lib/openmpi/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/lib/openmpi/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

### OpenMP
OpenMP is supported by default in GCC and Clang. No additional installation is needed.

---

## Step 4: Install Mathematical Libraries

### BLAS and LAPACK
```bash
sudo pacman -S blas lapack
```

### FFTW (Fast Fourier Transform)
```bash
sudo pacman -S fftw
```

### Intel MKL (Optional)
For Intel processors, Intel MKL can provide better performance. Install it from the Arch User Repository (AUR):
```bash
git clone https://aur.archlinux.org/intel-mkl.git
cd intel-mkl
makepkg -si
```

---

## Step 5: Install Python and Scientific Libraries
Install Python with common HPC libraries:
```bash
sudo pacman -S python python-numpy python-scipy python-matplotlib
```
For additional packages, use `pip`:
```bash
pip install mpi4py
```

---

## Step 6: Install and Configure GPU Computing Tools (Optional)

### NVIDIA CUDA Toolkit
If using an NVIDIA GPU:
```bash
sudo pacman -S cuda
```
Add CUDA paths to your environment:
```bash
echo 'export PATH=/opt/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

### AMD ROCm Toolkit
For AMD GPUs:
```bash
git clone https://aur.archlinux.org/rocm-arch.git
cd rocm-arch
makepkg -si
```

---

## Step 7: Configure Performance Tuning

### Install Performance Monitoring Tools
```bash
sudo pacman -S htop perf
```

### Set CPU Scaling Governor
Set the CPU governor to `performance` for consistent high performance:
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g performance
```

### Enable Huge Pages
```bash
echo "vm.nr_hugepages=128" | sudo tee -a /etc/sysctl.d/hugepages.conf
sudo sysctl -p /etc/sysctl.d/hugepages.conf
```

---

## Step 8: Testing and Validation

### Test MPI
Create a simple MPI program and run:
```bash
mpicc -o mpi_hello mpi_hello.c
mpirun -np 4 ./mpi_hello
```

### Test OpenMP
Compile and run a simple OpenMP program:
```bash
gcc -fopenmp -o omp_hello omp_hello.c
./omp_hello
```

---

## Additional Notes
- Use the `pacman` package manager for most installations.
- Regularly update your system to maintain security and performance.

By following these steps, your Arch Linux system will be ready for high-performance computing and multi-thread programming tasks.
