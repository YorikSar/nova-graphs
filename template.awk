BEGIN {
    for (i=2; i<ARGC; i++) {
        names[i] = ARGV[i];
        sub("\\.svg", "", names[i]);
        delete ARGV[i];
    }
    asort(names);
}
/FILENAME/ {
    for (i in names) {
        t = $0;
        gsub("FILENAME", names[i], t);
        print t;
    }
}
!/FILENAME/ { print $0; }
