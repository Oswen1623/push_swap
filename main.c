/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/10 15:25:58 by lucinguy          #+#    #+#             */
/*   Updated: 2025/12/12 17:17:20 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	main(int argc, char **argv)
{
	char	**newstring;
	int		i;

	// t_stack_node	a;
	// t_stack_node	b;
	// a = NULL;
	// b = NULL;
	newstring = NULL;
	i = 0;
	if ((argc == 1) || (argc == 2 && !argv[1][0]))
		return (1);
	else if (argc == 2)
		newstring = ft_split(argv[1], ' ');
	// while (newstring[i <= argc])
	// {
	// 	ft_printf("%s\n", newstring[i++]);
	// }
	ft_printf("%s\n", newstring[0]);
	ft_printf("%s\n", newstring[1]);
	ft_printf("%s\n", newstring[2]);
}
