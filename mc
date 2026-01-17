default partial alphanumeric_keys
xkb_symbols "basic" {
    name[Group1] = "Minecraft";


    key <AE10> { [ 0, 0 ] };                        // CAPS > 0
    key <AE01> { [ 1, 8 ] };                        // 1 > 1 (shift 8)
    key <AE02> { [ 2, plus ] };                     // 2 > 2 (shift +)
    key <AE03> { [ 3, period ] };                   // 3 > 3 (shift .)
    key <AE04> { [ 4, 4 ] };                        // 4 > 4


    key <AD01> { [ o, O ] };                        // Q > O
    key <AD02> { [ w, W ] };                        // W > W
    key <AD03> { [ e, E ] };                        // E > E
    key <AD04> { [ r, R ] };                        // R > R
    key <AC08> { [ t, T ] };                        // T > T (K)


    key <AC09> { [ a , A ] };                       // A > A (L)
    key <AC02> { [ s, S ] };                        // S > S
    // SKIP D                                       // D > BKSP
    key <AC04> { [ b , B ] };                       // F > B


    key <AB01> { [ x , X ] };                       // Z > X
    // SKIP X                                       // X > RShift
    key <AB03> { [ c , C ] };                       // C > C
    key <AB04> { [ i , I ] };                       // V > I

};

