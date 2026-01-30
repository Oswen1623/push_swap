# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/10 11:38:44 by lucinguy          #+#    #+#              #
#    Updated: 2026/01/29 17:31:58 by lucinguy         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= push_swap
CC			:= cc
CFLAGS		:= -Wall -Wextra -Werror
RM			:= rm -f
INCS		:= -I . -I ./ft_printf

PRINTF_DIR	:= ft_printf
PRINTF_LIB	:= $(PRINTF_DIR)/libftprintf.a

SRCS		:= \
	main.c \
	init_stack.c \
	utils_stacks.c \
	errors.c \
	a_to_b.c \
	b_to_a.c \
	c_push.c \
	c_rotate.c \
	c_rev_rotate.c \
	c_swap.c \
	c_sort_three.c \
	sort_three.c \
	sort_stacks.c \
	ft_atol.c \
	ft_split.c

OBJS		:= $(SRCS:.c=.o)

.PHONY: all clean fclean re

all: $(PRINTF_LIB) $(NAME)

$(PRINTF_LIB):
	$(MAKE) -C $(PRINTF_DIR)

$(NAME): $(OBJS) $(PRINTF_LIB)
	$(CC) $(CFLAGS) $(OBJS) $(PRINTF_LIB) -o $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

clean:
	$(RM) $(OBJS)
	$(MAKE) -C $(PRINTF_DIR) clean

fclean: clean
	$(RM) $(NAME)
	$(MAKE) -C $(PRINTF_DIR) fclean

re: fclean all
