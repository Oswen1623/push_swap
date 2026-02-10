/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/10 15:25:58 by lucinguy          #+#    #+#             */
/*   Updated: 2026/02/10 12:28:16 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	sort_by_size(t_stack_node **a, t_stack_node **b)
{
	int	len;

	if (stack_sorted(*a))
		return ;
	len = stack_len(*a);
	if (len == 2)
		sa(a, true);
	else if (len == 3)
		sort_three(a);
	else
		sort_stacks(a, b);
}

static void	cleanup_split(char **split_args)
{
	int	i;

	if (!split_args)
		return ;
	i = 0;
	while (split_args[i])
		free(split_args[i++]);
	free(split_args);
}

int	main(int argc, char **argv)
{
	t_stack_node	*a;
	t_stack_node	*b;
	char			**split_args;

	a = NULL;
	b = NULL;
	split_args = NULL;
	if (argc == 1 || (argc == 2 && !argv[1][0]))
		return (1);
	if (argc == 2)
	{
		split_args = ft_split(argv[1], ' ');
		argv = split_args - 1;
	}
	init_stack_a(&a, argv + 1);
	sort_by_size(&a, &b);
	free_stack(&a);
	cleanup_split(split_args);
	return (0);
}
