#include <fstream>
#include <string>

int main() {
    auto start = 0;  
    auto end = 255;
    auto latency = 1'000'000'000;

    std::string filename = "./generated_nums.txt";
    std::ofstream file(filename);

    for (int num = start; num <= end; ++num) {
        file << "num = 8'd" << num << ";  #" << latency << "; $display(\"%d \\t %b\", num, result);" << std::endl;
    }

    return 0;
}
