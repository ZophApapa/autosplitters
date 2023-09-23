/*
    ASL script for Asterix and Obelix - Bash Them All! (Europe).
    - GitHub: https://github.com/Zophiss/autosplitters
*/

state("LiveSplit") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("GBA");

    settings.Add("level_2", true, "Intro 2-1");
    settings.Add("level_3", true, "Intro 2-2");
    settings.Add("level_5", true, "Intro 3");
    settings.Add("level_8", true, "Londinium 1-1");
    settings.Add("level_9", true, "Londinium 1-2");
    settings.Add("level_11", true, "Londinium 2");
    settings.Add("level_12", true, "Swiss frontier 1");
    settings.Add("level_14", true, "Swiss frontier 2");
    settings.Add("level_16", true, "Mountain 1");
    settings.Add("level_18", true, "Mountain 2");
    settings.Add("level_20", true, "Piree 1");
    settings.Add("level_22", true, "Piree 2");
    settings.Add("level_24", true, "Olympus 1");
    settings.Add("level_26", true, "Olympus 2");
    settings.Add("level_32", true, "Mesopotamia 1");
    settings.Add("level_34", true, "Mesopotamia 2");
    settings.Add("level_36", true, "Dead Sea 1");
    settings.Add("level_38", true, "Dead sea 2");
    settings.Add("level_39", true, "Pirate crew 1");
    settings.Add("level_41", true, "Pirate crew 2");
    settings.Add("level_43", true, "SPQR Camp 1");
    settings.Add("level_45", true, "SPQR Camp 2");
}

onStart {
    vars.nbStun = 0;
}

init {
    vars.Helper.Load = (Func<dynamic, bool>)(emu =>
    {
        emu.Make<byte>("inGame", 0x30014AC); // 0x14AC
        emu.Make<byte>("lvl",    0x3001528); // 0x1528
        emu.Make<byte>("lives",  0x300037A); // 0x37A
        emu.Make<bool>("stun",   0x3001545); // 0x1545

        return true;
    });
}

start {
    return (old.inGame == 0 && current.inGame == 30);
}

split {
    if (old.lvl != current.lvl) {
        return settings["level_" + current.lvl];
    }

    if (current.lvl == 45) {
        if (old.lives > current.lives) {
            vars.nbStun = 0;
        }

        if (!old.stun && current.stun) {
            vars.nbStun++;
        }

        return vars.nbStun == 3;
    }
}