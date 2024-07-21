import random, os, sys, time

intro = input("Do you know the rules? (y/n)\n")
if intro.lower() == "n":
    input("This is a game of guessing numbers.\n")
    input("If you guess the same number as the machine, given a certain range, your System 32 gets deleted.\n")
    input("Every time you play the number changes.\n")
    input("For this to be a real challenge, I recommend you run it in admin mode.\n")
    
def loading(loops):
    for i in range(loops + 1):
        sys.stdout.write('\r|')
        time.sleep(0.1)
        sys.stdout.write('\r/')
        time.sleep(0.1)
        sys.stdout.write('\r-')
        time.sleep(0.1)
        sys.stdout.write('\r\\')
        time.sleep(0.1)

def pre(loop:int):
    if loop == 1:
        input("Good choice.\n")
    else:
        input("Lets begin.\n")
    try:
        bullets = int(input("How big do you want the chamber (range of numbers to guess) to be? (Positive integers only)\n"))
        if bullets <= 0:
            print("Positive integers only.")
            replay()
    except ValueError:
        print("\n Please enter an integer.\n")
        replay()
    main(bullets)

def replay():
    repeat = str(input("Want to try again? (y/n)\n"))
    if repeat.lower() == "y":
        pre(1)
    else:
        print("Thanks for playing.")
        sys.exit()
    
    
def main(bullets):
    #Simulating real loading. Whenever the barrel of the gun is bigger, the more it takes to load, even though its a pseudo-load.
    loading(random.randint(0,int(bullets/137)))
    try:
        guess = int(input("\nEnter your guess:\n"))
    except ValueError:
        print("You need to enter an integer")
        replay()
    
    #Cases where the user always wins.
    if guess > bullets:
        print("You need to enter an integer INSIDE the range you've given.")
        replay()
            
    rand = random.randint(0, bullets + 1)
    if rand == guess:
        input("You lose.\n")
        #os.remove("C:\Windows\System32")
        sys.exit()
        
       
    input("You won!\n")
    input(f"Your number = {guess}\n")
    input(f"Machine's number = {rand}\n")
    replay()
    
        
pre(0)

#Microwavedd