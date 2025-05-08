// Aleksandar Stojanović, 12411325
// Annika Schmidthaler, 12411307
// Benedikt Zöchmann, 12410383

#include <stdio.h>
#include <math.h>

float data0[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
float data1[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

int main() {
    for (int i = 0; i < 6; i++) {
        data0[i] = (i * i) * M_PI; // data0[i] = Fläche von Kreis mit r=i ->, r^2 * π
        data1[i] = (i * 2) * M_PI; // data0[i] = Umfang von Kreis mit r=i -> 2r*π
    }
    
    // Ausgabe Flächenwerte
    printf("data0:\n");
    for (int i = 0; i < 6; i++) {
        printf("  data0[%d] = %.6f\n", i, data0[i]);
    }

    // Ausgabe Umfangwerte
    printf("\ndata1:\n");
    for (int i = 0; i < 6; i++) {
        printf("  data1[%d] = %.6f\n", i, data1[i]);
    }

    return 0;
}