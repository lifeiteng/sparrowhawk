#include <sparrowhawk/normalizer.h>

#ifndef DATADIR
#define DATADIR ../data
#endif

using namespace std;

int main(int argc, char **argv) {

    string af_dir = DATADIR"/af/";

    speech::sparrowhawk::Normalizer normalizer;
    normalizer.Setup("sparrowhawk_configuration.ascii_proto", af_dir);

    string in = "I have 123 apples.";
    string out = "";

    normalizer.Normalize(in, &out);

    cout << " INPUT: " << in << endl;
    cout << "OUTPUT: " << out << endl;

    return 0;
}
