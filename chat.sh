#!/bin/bash
 
# Path to the shared chat files

CHAT_LOG="chat.log"

CHAT_HISTORY="chat_history.txt"

LOGIN_HISTORY="login_history.txt"

LOGGED_IN_USERS="logged_in_users.txt"

USER_DB="logindb.txt"
 
PORT=5201
 
touch $CHAT_HISTORY

touch $LOGIN_HISTORY

touch $LOGGED_IN_USERS

touch $CHAT_LOG

touch $USER_DB
 
# function to show chat history

show_chat_history() {

    if [ ! -f "$CHAT_HISTORY" ]; then

        echo "No chat history."

        return

    fi

    echo "History of a chat:"

    less "$CHAT_HISTORY"

}
 
# function to show logged users

show_logged_in_users() {

    if [ ! -s "$LOGGED_IN_USERS" ]; then

        echo "No logged in users."

        return

    fi

    echo "Logged in users:"

    cat "$LOGGED_IN_USERS"

}
 
# checks if user has a login if yes askes them to login which checks their credentials against a database.txt file

# else redirects them to a regusterpage where their details are saved in the database.txt file unless that username

# has been used

# Function for reg

register() {

    echo "===== Registration ====="

    read -p "Enter your username: " username

    read -sp "Enter your password: " password

    echo ""
 
    if grep -q "$username" "$USER_DB"; then

            echo "User already exists"

            return 1

    else

            echo "$username:$password" >> logindb.txt

            echo "Registration successful! Redirecting to chat."

            echo""

            echo""

            return 0

    fi

}
 
# login function

login() {

    echo "===== Login ====="

    read -p "Enter your username: " username

    read -sp "Enter your password: " password

    echo ""
 
    # Check if user exists in logindb.txt file

    if grep -q "$username:$password" "$USER_DB"; then

        echo "Login successful. Welcome $username!" | tee -a "$CHAT_HISTORY" "$LOGIN_HISTORY"

        echo "$username" >> "$LOGGED_IN_USERS"

        echo "$username has joined the chat" | nc localhost $PORT

        return 0

    else

        echo "Login failed. Invalid username or password."

        return 1

    fi

}
 
# logout the user

logout() {

    sed -i "/$username/d" "$LOGGED_IN_USERS"

    echo "$username logged out." | tee -a "$CHAT_HISTORY" "$LOGIN_HISTORY"

    echo "$username has left the chat" | nc localhost $PORT

    exit 0

}
 
 
# Function to handle a wide range of emojis

function emoji() {

    case $1 in

        # Declaration of emoji

        :smile) echo -e "\U1F600" ;;  # 😀 smile face

        :happy) echo -e "\U1F604" ;;  # 😄 happy face

        :joy) echo -e "\U1F602" ;;    # 😂 Tears of Joy; meaning the person is so so happy

        :love) echo -e "\U1F60D" ;;   # 😍 Smiling Face with Heart-Eyes

        :wink) echo -e "\U1F609" ;;   # 😉 Winking Face

        :sad) echo -e "\U1F622" ;;    # 😢 Crying Face

        :angry) echo -e "\U1F620" ;;  # 😠 Angry Face

        :cry) echo -e "\U1F62D" ;;    # 😭 Loudly Crying Face

        :cool) echo -e "\U1F60E" ;;   # 😎 Smiling Face with Sunglasses

        :party) echo -e "\U1F973" ;;  # 🥳 Partying Face

        :think) echo -e "\U1F914" ;;  # 🤔 Thinking Face

        :scream) echo -e "\U1F631" ;; # 😱 Face Screaming in Fear

        :hug) echo -e "\U1F917" ;;    # 🤗 Hugging Face

        :zzz) echo -e "\U1F634" ;;    # 😴 Sleeping Face

        :dog) echo -e "\U1F436" ;;    # 🐶 Dog Face

        :cat) echo -e "\U1F431" ;;    # 🐱 Cat Face

        :lion) echo -e "\U1F981" ;;   # 🦁 Lion Face

        :tiger) echo -e "\U1F42F" ;;  # 🐯 Tiger Face

        :frog) echo -e "\U1F438" ;;   # 🐸 Frog Face

        :unicorn) echo -e "\U1F984" ;;# 🦄 Unicorn

        :chick) echo -e "\U1F423" ;;  # 🐣 Hatching Chick

        :snake) echo -e "\U1F40D" ;;  # 🐍 Snake

        :panda) echo -e "\U1F43C" ;;  # 🐼 Panda Face

        :monkey) echo -e "\U1F435" ;; # 🐵 Monkey Face

        :whale) echo -e "\U1F433" ;;  # 🐳 Spouting Whale

        :flower) echo -e "\U1F33C" ;; # 🌸 Cherry Blossom

        :sun) echo -e "\U2600" ;;     # ☀  Sun

        :tree) echo -e "\U1F333" ;;   # 🌳 Tree

        :pizza) echo -e "\U1F355" ;;  # 🍕 Pizza

        :burger) echo -e "\U1F354" ;; # 🍔 Hamburger

        :fries) echo -e "\U1F35F" ;;  # 🍟 French Fries

        :beer) echo -e "\U1F37A" ;;   # 🍺 Beer Mug

        :wine) echo -e "\U1F377" ;;   # 🍷 Wine Glass

        :apple) echo -e "\U1F34E" ;;  # 🍎 Red Apple

        :banana) echo -e "\U1F34C" ;; # 🍌 Banana

        :grapes) echo -e "\U1F347" ;; # 🍇 Grapes

        :watermelon) echo -e "\U1F349" ;; # 🍉 Watermelon

        :sushi) echo -e "\U1F363" ;;  # 🍣 Sushi

        :cake) echo -e "\U1F370" ;;   # 🍰 Shortcake

        :doughnut) echo -e "\U1F369" ;;# 🍩 Doughnut

        :soccer) echo -e "\U26BD" ;;  # ⚽ Soccer Ball

        :basketball) echo -e "\U1F3C0" ;; # 🏀 Basketball

        :guitar) echo -e "\U1F3B8" ;; # 🎸 Guitar

        :video_game) echo -e "\U1F3AE" ;; # 🎮 Video Game

        :trophy) echo -e "\U1F3C6" ;; # 🏆 Trophy

        :bullseye) echo -e "\U1F3AF" ;; # 🎯 Bullseye

        :game_die) echo -e "\U1F3B2" ;; # 🎲 Game Die

        :swimmer) echo -e "\U1F3CA" ;; # 🏊 Swimmer

        :cyclist) echo -e "\U1F6B4" ;; # 🚴 Cyclist

        :car) echo -e "\U1F697" ;;    # 🚗 Car

        :taxi) echo -e "\U1F695" ;;   # 🚕 Taxi

        :bus) echo -e "\U1F68C" ;;    # 🚌 Bus

        :airplane) echo -e "\U2708" ;;# ✈ Airplane

        :rocket) echo -e "\U1F680" ;; # 🚀 Rocket

        :ship) echo -e "\U1F6A2" ;;   # 🚢 Ship

        :house) echo -e "\U1F3E0" ;;  # 🏠 House

        :beach) echo -e "\U1F3D6" ;;  # 🏖️ Beach with Umbrella

        :mountain) echo -e "\U1F3D4" ;;# 🏔️ Snow-Capped Mountain

        :heart) echo -e "\U2764" ;;   # ❤ Red Heart

        :broken_heart) echo -e "\U1F494" ;; # 💔 Broken Heart

        :star) echo -e "\U2B50" ;;    # ⭐ Star

        :light_bulb) echo -e "\U1F4A1" ;; # 💡 Light Bulb

        :fire) echo -e "\U1F525" ;;   # 🔥 Fire

        :party_popper) echo -e "\U1F389" ;;# 🎉 Party Popper

        :100) echo -e "\U1F4AF" ;;    # 💯 100

        :speech_bubble) echo -e "\U1F4AC" ;;# 💬 Speech Bubble

        :voltage) echo -e "\U26A1" ;;     # ⚡ High Voltage

        :umbrella) echo -e "\U2602" ;;# ☂ Umbrella
 
        *) echo "$1" ;;  # Return the main message if no emoji keyword is found

    esac

}
 
# main menu function

menu() {

    while true; do

        echo " "

        echo "Menu:"

        echo "1) Start chatting"

        echo "2) Print the history of a chat"

        echo "3) Show logged users"

        echo "4) Exit"

        read -p "Choose an option: " option

        case $option in

            1)

                chat_loop

                ;;

            2)

                show_chat_history

                ;;

            3)

                show_logged_in_users

                ;;

            4)

                logout

                ;;

            *)

                echo "Wrong option. Try again."

                ;;

        esac

    done

}
 
# function to send a message

chat_loop() {

        echo "----- Start chatting! Type '/exit' to exit. -----"
 
        while true; do
 
        # Prompt the user to enter a message

        read -p "$username: " message
 
        # Check if the user wants to quit the chat

        if [ "$message" == "/exit" ]; then

                echo "$username has left the chat." >> "$CHAT_LOG"

                break

        fi
 
        # Split the message into words and process each one for emoji translation

        processed_message=""

        for word in $message; do

                processed_message+="$(emoji $word) "

        done
 
        # Append the user's processed message to the chat log with a timestamp

            echo "$(date +'%H:%M') $username: $processed_message" | tee -a "$CHAT_HISTORY" | nc localhost $PORT

        done
 
}
 
# Main script logic

echo "Do you have an account? (y/n)"

read -p "> " response
 
if [[ "$response" == "y" || "$response" == "Y" ]]; then

    login

    if [ $? -eq 0 ]; then

            echo "Starting chat server..."

            #start the menu function

            menu
 
            # Start chat server

            # connect to netcat ip or open chat script eg nc -l -p 12345

    fi
 
elif [[ "$response" == "n" || "$response" == "N" ]]; then

    register

    if [ $? -eq 0 ]; then

            echo "Starting chat server..."

            #start the menu function

            menu
 
            # Start chat server

            # connect to netcat ip or open chat script eg nc -l -p 12345

    fi

else

    echo "Invalid response. Please enter 'y' or 'n'."

fi
 
