#!/usr/bin/sh -i

if [ -d "$HOME/venv" ]; then
   echo "Virtual environoment found... Activating"
else
   echo "Couldn't find Python virtual environment..."
   echo "Creating one and installing mpi4py"
   python3 -m venv $HOME/venv
fi

source $HOME/venv/bin/activate
pip install --upgrade pip
pip install mpi4py

echo "Purging loaded modules..."
module purge
echo "Loading modules to build NGSolve"
module load Utils/lapack/3.8.0/gcc-8.2.0
module load openmpi-3.0.1/gcc-9.2.0
module load cmake/3.21.0/gcc-9.2.0

# Make sure CMake knows to use the correct compilers
export CXX=/vol/apps/gcc/gcc-9.2.0/bin/c++
export CC=/vol/apps/gcc/gcc-9.2.0/bin/gcc

export BASEDIR=$HOME/ngsuite

# Just delete everything and start over because it's easier
[ -d "$BASEDIR" ] && rm -rf $BASEDIR
mkdir $BASEDIR

# CMake directories for NGSolve
export NGSOLVE_BUILD_DIR=$BASEDIR/ngsolve-build
export NGSOLVE_INSTALL_DIR=$BASEDIR/ngsolve-install
export NGSOLVE_SRC_DIR=$BASEDIR/ngsolve-src

# CMake directories for Open Cascade
export OCC_BUILD_DIR=$BASEDIR/occ-build
export OCC_INSTALL_DIR=$BASEDIR/occ-install
export OCC_SRC_DIR=$BASEDIR/occ-src

# Clone, build, and install OCC
git clone https://github.com/Open-Cascade-SAS/OCCT $OCC_SRC_DIR
mkdir $OCC_INSTALL_DIR
mkdir $OCC_BUILD_DIR
cd $OCC_BUILD_DIR
cmake -DCMAKE_INSTALL_PREFIX=$OCC_INSTALL_DIR $OCC_SRC_DIR
make -j20
make install

# Update paths to include OCC
export LD_LIBRARY_PATH=$OCC_INSTALL_DIR/lib/:$LD_LIBRARY_PATH
export PATH=$OCC_INSTALL_DIR/bin/:$PATH

# Clone, build, and install NGSolve
git clone https://github.com/NGSolve/ngsolve.git $NGSOLVE_SRC_DIR
cd $NGSOLVE_SRC_DIR
git submodule update --init --recursive
mkdir $NGSOLVE_BUILD_DIR
mkdir $NGSOLVE_INSTALL_DIR
cd $NGSOLVE_BUILD_DIR
cmake -DCMAKE_INSTALL_PREFIX=$NGSOLVE_INSTALL_DIR -DUSE_MPI=ON -DUSE_OCC=ON $NGSOLVE_SRC_DIR
make -j20
make install

# Update paths to include NGSolve
export LD_LIBRARY_PATH=$NGSOLVE_INSTALL_DIR/lib/:$LD_LIBRARY_PATH
export PATH=$NGSOLVE_INSTALL_DIR/bin/:$PATH
