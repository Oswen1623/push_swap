This project has been created as part of the 42 curriculum by lucinguy.

Description

The goal of this project is to write an algorithm sorting given numbers, placed in a stack 'a', using another empty stack 'b', with the lowest possible number of operations. The program must be written in C.

Instructions

A Makefile must be turned in to compile the source files. We have to write a program named push_swap that takes as an argument the stack a formatted as a list of integers. The first argument should be at the top of the stack. The program must display the shortest sequence of operations necessary to sort the 'a' stack, the smallest number at the top, the biggest at the bottom. Numbers must be followed by a newline. If no parameters are specified, the program must not display anything and should
return to the prompt. In case of error, it must display "Error" followed by an ’\n’ on the standard error. Errors include, for example: some arguments not being integers, some arguments exceeding the integer limits, and/or the presence of duplicates.
To determine wether the program sorts correctly, a checker has been provided, and a benchmark has been established to evaluate the effectiveness of the sorting algorithm :  
For maximum project validation (100%) :  
◦ Sort 100 random numbers in fewer than 700 operations.  
◦ Sort 500 random numbers in no more than 5500 operations.  
For minimal project validation :  
    ◦ 100 numbers in under 1100 operations and 500 numbers in under 8500 operations  
    ◦ 100 numbers in under 700 operations and 500 numbers in under 11500 operations  
    ◦ 100 numbers in under 1300 operations and 500 numbers in under 5500 operations  

Resources  

This tutorial has helped me a lot through this project, since it was kinda complex. The turkish algorithm is well explained and detailed and the code in general is clear. Altough, I changed some things that didn't feel right or comfortable to me :  
https://youtu.be/wRvipSG4Mmk?si=TfFDLsx-GHhyUbNP  
I also went through these Medium articles to help visualise the turkish algorithm steps :  
https://pure-forest.medium.com/push-swap-turk-algorithm-explained-in-6-steps-4c6650a458c0  
https://medium.com/@ayogun/push-swap-c1f5d2d41e97  
AI has only be used as a debugger or to refactor long functions.  

Usage examples :  

'make' to compile the source files.  
'./push_swap [numbers]' to execute the program with the [numbers] given as parameters.  
