# README

### Expert "Broker" System in CLIPS

This system is an expert "Broker" system written in the CLIPS language. It is designed to assist users in finding the perfect house to buy or rent based on their preferences. The program is composed of several rules and templates to describe the characteristics of different houses and provide recommendations based on user input.

### Requirements

CLIPS 6.4 or later


### How to use

1. Clone the repository to your local machine.
2. Install CLIPS 6.4 or later on your system.
3. Open the CLIPS command prompt or terminal and navigate to the directory containing the clips files.
4. Load the clips file by typing (load "house_broker.clp") in the CLIPS command prompt or terminal.
5. Run the program by typing (run) in the CLIPS command prompt or terminal.
6. Follow the prompts to input your preferences and get recommendations for houses.


###CLIPS Code
The code is composed of several parts:

1. The "house" template that describes the characteristics of a house.
2. The "houses-db" fact that contains information on different houses.
3. The "get-user-input" rule that gets user inputs and asserts them as facts into the working memory.
4. Several rules that match user input against house characteristics to provide recommendations.

### Contributing
If you find any issues or have any suggestions, feel free to open an issue or pull request.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
