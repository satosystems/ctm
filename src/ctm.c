#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#define VERSION "0.1.0"

int main(int argc, char *argv[]) {
    struct timeval tv;
    unsigned long long msec;

    if (argc == 2 && strcmp(argv[1], "-v") == 0) {
        printf("ctm version: %s\n", VERSION);
        return EXIT_SUCCESS;
    }

    timerclear(&tv);

    gettimeofday(&tv, NULL);
    msec = tv.tv_sec;
    msec *= 1000;
    msec += tv.tv_usec / 1000;

    printf("%llu", msec);

    return EXIT_SUCCESS;
}

