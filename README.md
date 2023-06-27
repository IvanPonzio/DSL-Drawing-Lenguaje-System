# Functional Programming DSL - Drawing Language System (DLS)

## Description
The Functional Programming DSL project aims to teach functional programming from a practical perspective, focusing on how to solve specific problems with a functional mindset. Two main aspects are emphasized:

1. Separation between data and functions: The project encourages separating information (data) from processing (functions).
2. Functions as values and higher-order functions: The project explores the concept of treating functions as values and working with higher-order functions (functions that take other functions as arguments).

Additionally, there are two horizontal objectives that apply to all labs:

1. Dealing with a new programming language: If you already have knowledge of Haskell, this lab will be easier for you. However, if you don't remember much from past experiences, it will be a challenge.
2. Reading, finding documentation, and setting up: The project encourages participants to practice reading and finding relevant documentation, installing dependencies, and configuring the environment.

## A Language Worth a Thousand Drawings

This lab focuses on implementing a small, specific language designed to combine basic drawings and create more interesting designs. Such languages are commonly known as Domain Specific Languages (DSLs) because they are intended to provide suitable abstractions for solving problems within a specific domain. The original idea for this language can be found in Peter Henderson's article, which we recommend reading.

To define a language, we need two things: its syntax (how it will be written) and its semantics (how it will be interpreted). For example, in the language we are going to explore, we will write a rotation operator and interpret it as rotating an image. In our case, this interpretation will be achieved through a function that transforms DSL programs into drawings on the screen. Other interpretations are also possible, such as writing to a file, sending packets over a network interface, etc.

## The Lab
In this project, you will need to:

1. Implement the DSL in Haskell, which consists of two parts:
   - Implement the language's syntax, i.e., define how the "words" of the language will be structured.
   - Implement the semantics. This involves providing a function that takes a "word" and returns an interpretation, which in our case is a drawing that corresponds to the instructions described by the word. To accomplish this, you will use the Gloss graphics library (earning extra credit and eternal gratitude from Beta if you use another library).

2. Utilize the DSL to create specific drawings. In this case, the goal is to reproduce a simplified version of the Escher figure shown in Henderson's article. This figure consists of a repeated and altered shape that forms a complex composition. This task includes the following activities:
   - Correctly visualize the test graph that draws all the operations on the primitive shapes.
   - Create a grid of horizontal and vertical lines.
   - Reproduce the Escher drawing.
   - Extend the user interface of the main program to display the names of all registered drawings.

Feel free to get creative and create additional drawings!

3. Write tests, preferably using artificial intelligence tools for code generation.

4. Provide detailed answers to questions related to the lab.

## Requirements
- Haskell
- Gloss graphics library (or another graphics library, if preferred)

## Installation
1. Clone the repository: `git clone https://github.com/IvanPonzio/DSL-Drawing-Lenguaje-System.git`
2. Install Haskell and the required dependencies.
3. Compile and run the project.

## Usage
1. Navigate to the project directory: `cd project-directory`
2. Run the program: `runhaskell main.hs`
3. Follow the instructions on the screen to interact with the DSL and create drawings.

## Testing
1. Navigate to the project directory: `cd project-directory`
2. Run the tests:

 `runhaskell tests.hs`
3. Review the test results and ensure all functionality is working as expected.

## FAQ
**Q: What programming language is used for this project?**
A: This project is implemented in Haskell.

**Q: Can I use a different graphics library instead of Gloss?**
A: Yes, you can use another graphics library if you prefer. However, using Gloss is recommended.

**Q: Where can I find more information about DSLs and functional programming?**
A: The article by Peter Henderson mentioned in the project description is a good starting point. Additionally, there are numerous online resources and books available that cover the topics of DSLs and functional programming.

**Q: How can I contribute to this project?**
A: Contributions to this project are welcome! Please fork the repository, make your changes, and submit a pull request explaining the modifications you've made.

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgements
This laboratory was created at Famaf (Facultad de Matemática, Astronomía, Física y Computación) as part of the functional programming curriculum.

For more information, please refer to the License file.
