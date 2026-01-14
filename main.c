/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/10 15:25:58 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/14 18:32:15 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	main(int argc, char **argv)
{
	char	**newstring;
	long	*convd;
	int		i;
	int		size;

	newstring = NULL;
	convd = NULL;
	i = 0;
	if ((argc == 1) || (argc == 2 && !argv[1][0]))
		return (1);
	else if (argc == 2)
	{
		newstring = ft_split(argv[1], ' ');
		size = 0;
		while (newstring[size])
			size++;
		convd = malloc(sizeof(long) * size);
		i = 0;
		while (i < size)
		{
			convd[i] = ft_atol(newstring[i]);
			i++;
		}
		free(newstring);
	}
	else
	{
		convd = multiple_strings(argc, argv);
	}
	free(convd);
	return (0);
}
