/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/10 15:25:58 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/13 17:17:54 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	main(int argc, char **argv)
{
	void	**newstring;
	int		i;
	long	convd[argc - 1];

	newstring = NULL;
	i = 0;
	convd[0] = 0;
	if ((argc == 1) || (argc == 2 && !argv[1][0]))
		return (1);
	else if (argc == 2)
	{
		newstring = ft_split(argv[1], ' ');
		while (newstring[i++])
			newstring[i] = ft_atol(newstring[i]);
	}
	else
		newstring = multiple_args(argc, **argv);
	if (!newstring)
		return (1);
	free(newstring);
	return (0);
}
