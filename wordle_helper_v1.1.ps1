function write-splash{
    write-host -foregroundcolor "green" "
     __      __                .___.__             ___ ___         .__                       
    /  \    /  \___________  __| _/|  |   ____    /   |   \   ____ |  | ______   ___________ 
    \   \/\/   /  _ \_  __ \/ __ | |  | _/ __ \  /    ~    \_/ __ \|  | \____ \_/ __ \_  __ \
     \        (  <_> )  | \/ /_/ | |  |_\  ___/  \    Y    /\  ___/|  |_|  |_> >  ___/|  | \/
      \__/\  / \____/|__|  \____ | |____/\___  >  \___|_  /  \___  >____/   __/ \___  >__|   
           \/                   \/           \/         \/       \/     |__|        \/    
           "
}

$dict = get-content "$pwd\official.txt"
$pos_1 = "\S"
$pos_2 = "\S"
$pos_3 = "\S"
$pos_4 = "\S"
$pos_5 = "\S"
get-rgx
function get-rgx {
    $script:rgx_string = "[$pos_1][$pos_2][$pos_3][$pos_4][$pos_5]"
}
function get-possibles {
    get-rgx
    $possibles = foreach ($i in $dict){
        (select-string -inputobject $i -pattern $rgx_string -allmatches).matches.value
    }
    $possibles | ft -autosize
}


# Menu
function write-menu {
    write-host ""
    write-host -foregroundcolor "blue" "    Menu:"
    write-host -foregroundcolor "blue" "
    Enter '1' to select a position to add unknown letters to.
    Enter '2' to select a position for which you know the correct letter.
    Enter 'quit' to exit the application."
    write-host ""
    $usr_input = read-host "What would you like to do?"

    if ($usr_input -eq 1){
        # Enter incorrect letter to position
        $wrong_pos = read-host "Please enter the position to apply wrong character(s) to"
        $wrong_character = read-host "Please enter the characters that do not go in this position"
        if ($wrong_pos -eq 1){
            if ($pos_1 -match "^"){$pos_1 = $pos_1 -replace "\^",""}
            if ($pos_1 -ne "\S"){
                $pos_1 = "^$($pos_1 + $wrong_character)"
                get-possibles
                get-rgx
                write-menu
                } else {
                    $pos_1 = "^$wrong_character"
                    get-possibles
                    get-rgx
                    write-menu
                }
        } elseif ($wrong_pos -eq 2){
            if ($pos_2 -match "^"){$pos_2 = $pos_2 -replace "\^",""}
            if ($pos_2 -ne "\S"){
                $pos_2 = "^$($pos_2 + $wrong_character)"
                get-possibles
                get-rgx
                write-menu
                } else {
                    $pos_2 = "^$wrong_character"
                    get-possibles
                    get-rgx
                    write-menu
                }
        } elseif ($wrong_pos -eq 3){
            if ($pos_3 -match "^"){$pos_3 = $pos_3 -replace "\^",""}
            if ($pos_3 -ne "\S"){
                $pos_3 = "^$($pos_3 + $wrong_character)"
                get-possibles
                get-rgx
                write-menu
            } else {
                $pos_3 = "^$wrong_character"
                get-possibles
                get-rgx
                write-menu
            }
        } elseif ($wrong_pos -eq 4){
            if ($pos_4 -match "^"){$pos_4 = $pos_4 -replace "\^",""}
            if ($pos_4 -ne "\S"){
                $pos_4 = "^$($pos_4 + $wrong_character)"
                get-possibles
                get-rgx
                write-menu
                } else {
                    $pos_4 = "^$wrong_character"
                    get-possibles
                    get-rgx
                    write-menu
                }
        } elseif ($wrong_pos -eq 5){
            if ($pos_5 -match "^"){$pos_5 = $pos_5 -replace "\^",""}
            if ($pos_5 -ne "\S"){
                $pos_5 = "^$($pos_5 + $wrong_character)"
                get-possibles
                get-rgx
                write-menu
                } else {
                    $pos_5 = "^$wrong_character"
                    get-possibles
                    get-rgx
                    write-menu
                }
        } else {
            write-host "Please enter valid input."
            write-menu
        }
    } elseif ($usr_input -eq 2){
        # Enter known letter to position 
        $known_pos = read-host "Please enter the position to apply this correct character to"
        $known_character = read-host "Please enter the character that goes in this position"
        if ($known_pos -eq 1){
            $pos_1 = $known_character
            get-possibles
            write-menu
        } elseif ($known_pos -eq 2){
            $pos_2 = $known_character
            get-possibles
            write-menu
        } elseif ($known_pos -eq 3){
            $pos_3 = $known_character
            get-possibles
            write-menu
        } elseif ($known_pos -eq 4){
            $pos_4 = $known_character
            get-possibles
            write-menu
        } elseif ($known_pos -eq 5){
            $pos_5 = $known_character
            get-possibles
            write-menu
        } else {
            write-host "Please enter valid input."
            write-menu
        }
    } elseif ($usr_input -eq "quit"){
        # Exit script
        return
    } else {
        write-host "Please enter valid input."
        write-menu
    }
}


# Starting splash screen
clear-host
write-splash
write-menu