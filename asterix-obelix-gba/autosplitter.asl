/*
    ASL script for Asterix & Obelix - Bash Them All! (Europe).
    - GitHub: https://github.com/Zophiss/autosplitters
*/

state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");
    // Settings
    settings.Add("level_2-1", true, "Intro 2-1");
    settings.Add("level_2-2", true, "Intro 2-2");
    settings.Add("level_3", true, "Intro 3");
    settings.Add("level_4-1", true, "Londinium 1-1");
    settings.Add("level_4-2", true, "Londinium 1-2");
    settings.Add("level_5", true, "Londinium 2");
    settings.Add("level_6", true, "Swiss frontier 1");
    settings.Add("level_7", true, "Swiss frontier 2");
    settings.Add("level_8", true, "Mountain 1");
    settings.Add("level_9", true, "Mountain 2");
    settings.Add("level_10", true, "Piree 1");
    settings.Add("level_11", true, "Piree 2");
    settings.Add("level_12", true, "Olympus 1");
    settings.Add("level_13", true, "Olympus 2");
    settings.Add("level_14", true, "Mesopotamia 1");
    settings.Add("level_15", true, "Mesopotamia 2");
    settings.Add("level_16", true, "Dead Sea 1");
    settings.Add("level_17", true, "Dead sea 2");
    settings.Add("level_18", true, "Pirate crew 1");
    settings.Add("level_19", true, "Pirate crew 2");
    settings.Add("level_20", true, "SPQR Camp 1");
    settings.Add("level_21", true, "SPQR Camp 2");
}


init {
    vars.scanning = false;
    vars.tokenSource = new CancellationTokenSource();
    vars.token = vars.tokenSource.Token;
    vars.nbStun = (int) 0;

    vars.deadRamPtr = new List<IntPtr>{};

        vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<byte>("inGame", 0x030014AC); // 0x14AC
        emu.Make<byte>("lvl",    0x03001528); // 0x1528
        emu.Make<byte>("lives",  0x0300037A); // 0x37A
        emu.Make<byte>("stun",  0x03001545); // 0x1545
        return true;
    });
}

update {}

start {
    return (old.inGame == 0 && current.inGame == 30);
}

onStart {
    vars.nbStun = 0;
}

split {
    // Level 2-1
    if (settings["level_2-1"] && old.lvl != current.lvl && current.lvl == 2) {
        return true;
    }
    // Level 2-2
    if (settings["level_2-2"] && old.lvl != current.lvl && current.lvl == 3) {
        return true;
    }

    // Level 3
    if (settings["level_3"] && old.lvl != current.lvl && current.lvl == 5) {
        return true;
    }

    // Level 4-1
    if (settings["level_4-1"] && old.lvl != current.lvl && current.lvl == 8) {
        return true;
    }

    // Level 4-2
    if (settings["level_4-2"] && old.lvl != current.lvl && current.lvl == 9) {
        return true;
    }

    // Level 5
    if (settings["level_5"] && old.lvl != current.lvl && current.lvl == 11) {
        return true;
    }

    // Level 6
    if (settings["level_6"] && old.lvl != current.lvl && current.lvl == 12) {
        return true;
    }

    // Level 7
    if (settings["level_7"] && old.lvl != current.lvl && current.lvl == 14) {
        return true;
    }

    // Level 8
    if (settings["level_8"] && old.lvl != current.lvl && current.lvl == 16) {
        return true;
    }

    // Level 9
    if (settings["level_9"] && old.lvl != current.lvl && current.lvl == 18) {
        return true;
    }

    // Level 10
    if (settings["level_10"] && old.lvl != current.lvl && current.lvl == 20) {
        return true;
    }

    // Level 11
    if (settings["level_11"] && old.lvl != current.lvl && current.lvl == 22) {
        return true;
    }

    // Level 12
    if (settings["level_12"] && old.lvl != current.lvl && current.lvl == 24) {
        return true;
    }

    // Level 13
    if (settings["level_13"] && old.lvl != current.lvl && current.lvl == 26) {
        return true;
    }

    // Level 14
    if ( settings["level_14"] && old.lvl != current.lvl && current.lvl == 32) {
        return true;
    }

    // Level 15
    if ( settings["level_15"] && old.lvl != current.lvl && current.lvl == 34) {
        return true;
    }

    // Level 16
    if ( settings["level_16"] && old.lvl != current.lvl && current.lvl == 36) {
        return true;
    }

    // Level 17
    if ( settings["level_17"] && old.lvl != current.lvl && current.lvl == 38) {
        return true;
    }

    // Level 18
    if ( settings["level_18"] && old.lvl != current.lvl && current.lvl == 39) {
        return true;
    }

    // Level 20
    if (settings["level_19"] && old.lvl != current.lvl && current.lvl == 41) {
        return true;
    }

    // Level 21
    if (settings["level_20"] && old.lvl != current.lvl && current.lvl == 43) {
        return true;
    }

    // Level 22
    if (settings["level_21"] && old.lvl != current.lvl && current.lvl == 45) {
        return true;
    }

    // Fin
    if (current.lvl == 45) {
        if(current.lives < old.lives) {
            vars.nbStun = 0;
        }

        if(old.stun == 0 && current.stun == 1 ) {
            vars.nbStun = vars.nbStun + 1;
        }

        return vars.nbStun == 3;   
    }
}

reset {}

exit {}

shutdown {}