
#include <iostream>
#include <mpi.h>

int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <seconds>" << std::endl;
        MPI_Finalize();
        return 1;
    }
    int seconds = std::stoi(argv[1]);
    double start = MPI_Wtime();
    while ((MPI_Wtime() - start) < seconds) {
        // Spin (busy wait)
    }
    std::cout << "Done spinning for " << seconds << " seconds." << std::endl;
    MPI_Barrier(MPI_COMM_WORLD);
    MPI_Finalize();
    return 0;
}
