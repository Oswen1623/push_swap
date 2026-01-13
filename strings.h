/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strings.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/13 16:56:47 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/13 19:00:02 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

char	**multiple_strings(int argc, char **argv)
{
	long	*args;
	int		i;
	int		j;

	args = malloc(sizeof(long) * argc - 1);
	i = 0;
	j = 1;
	if (argc == 2)
	{
		while (argv[j++])
		{
			args[i++] = ft_atol(argv[j]);
		}
	}
	args[i++] = '\0';
	return (args);
}
