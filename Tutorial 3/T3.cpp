// T3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <chrono>
#include <iostream> // for using std::cout
#include <algorithm> // for using std::min and std::min_element
#include <stdlib.h> // For rand()
#include <time.h>	// For time()

int count = 0;
int max_depth = 0;
int window_depth = 0;
int overflows = 0;
int underflows = 0;
int filled_register = 2;

// set to whichever number of registers are being used
int register_sets = 16;

void overflow_handler() {
    if (window_depth > max_depth)
        max_depth = window_depth;

    if (filled_register < register_sets) {
        filled_register++;
    } else {
        overflows++;
    }
   
}

void underflow_handler() {
    if (filled_register > 2)
        filled_register --;

    else
        underflows ++;
}

int compute_pascal(int row, int position) {
    window_depth++;
    count++;
    overflow_handler();

    if (position == 1) {
        window_depth--;
        underflow_handler;
        return 1;
    } 
    else if (position == row) {
        window_depth--;
        underflow_handler;
        return 1;
    }
    else {
        int result = compute_pascal(row - 1, position) + compute_pascal(row - 1, position - 1);
        window_depth--;
        underflow_handler;
        return result;
    }
}

int main()
{
    int answer;
   

    using std::chrono::high_resolution_clock;
    using std::chrono::duration_cast;
    using std::chrono::duration;
    using std::chrono::milliseconds;

    answer = compute_pascal(30, 20);

    std::cout << "Answer: " << answer << "\n";
    std::cout << "Procedure calls: " << count << "\n";
    std::cout << "Max Depth: " << max_depth << "\n";
    std::cout << "Overflows: " << overflows << "\n";
    std::cout << "Underflows: " << underflows << "\n";

    
    /// getting the time it takes to run it
    int time = 0;
    double time1 = 0;

    for (int i = 0; i < 10; i++) {

        auto t1 = high_resolution_clock::now();
        answer = compute_pascal(30, 20);
        auto t2 = high_resolution_clock::now();

        /* Getting number of milliseconds as a double. */
        duration<double, std::milli> ms_double = t2 - t1;
        time1 += ms_double.count();
    }
    time1 /= 10;

    std::cout << "Average time: " << time1 << "ms";

    return 0;
}