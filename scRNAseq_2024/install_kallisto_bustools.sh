#!/usr/bin/bash

SOFTWARE=$1

# Function to install Bustools
install_bustools() {
    if ! command -v bustools &> /dev/null; then
        echo "Installing bustools"
        git clone https://github.com/BUStools/bustools.git
        cd bustools
        mkdir build
        cd build
        cmake -DCMAKE_INSTALL_PREFIX=~/local ..
        make
        make install
        cd src
        echo "export PATH=$PWD:\$PATH" >> ~/.bashrc
        source ~/.bashrc
        cd ../../../
    else 
        echo "bustools is already installed in your system"
    fi
}

# Function to install Kallisto
install_kallisto() {
    if ! command -v kallisto &> /dev/null; then
        echo "Installing Kallisto"
        git clone https://github.com/pachterlab/kallisto.git
        cd kallisto
        mkdir build
        cd build
        cmake -DCMAKE_INSTALL_PREFIX=~/local ..
        make
        make install
        cd src
        echo "export PATH=$PWD:\$PATH" >> ~/.bashrc
        source ~/.bashrc
        cd ../../../
    else 
        echo "kallisto is already installed in your system"
    fi
}


# Function to install kb-python
install_kb() {
    if ! command -v kb &> /dev/null; then
        echo "Installing kb"
        pip install kb-python
    else
        echo "kb is already installed in your system"
    fi
}

# Decision logic based on the SOFTWARE variable
# Convert SOFTWARE value to lowercase
software_lower=$(echo "$SOFTWARE" | tr '[:upper:]' '[:lower:]')

case $software_lower in
    "bustools")
        install_bustools
        ;;
    "kallisto")
        install_kallisto
        ;;
    "kb")
        install_kb
        ;;
    "all")
        install_kallisto
        install_bustools
        install_kb
        ;;
    *)
        echo "Invalid option. Please specify 'bustools', 'kallisto', or 'all'."
        ;;
esac
