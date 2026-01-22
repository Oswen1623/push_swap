/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   utils.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/12 12:34:15 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/16 15:25:00 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	isnum(char c)
{
	if (!(c >= 0 && c <= 9))
		return (0);
	else
		return (1);
}
int	check_args(char **argv)
{
	int	i;
	int	j;

	i = 0;
	j = 0;
	while (argv[i++])
	{
		j = 0;
		while (argv[i][j])
		{
			if (!(isnum(argv[j++])))
			{
				error();
			}
		}
	}
}
void	error(void)
{
	ft_printf("Error\n");
	exit(EXIT_FAILURE);
}
