/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atol.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/12 17:09:39 by lucinguy          #+#    #+#             */
/*   Updated: 2025/12/12 17:15:14 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

// static long	ft_atol(const char *str)
// {
// 	long	num;
// 	int		isneg;
// 	int		i;

// 	num = 0;
// 	isneg = 1;
// 	i = 0;
// 	while (str[i] && (str[i] == ' ' || str[i] == '\t' || str[i] == '\n'
// 			|| str[i] == '\r' || str[i] == '\v' || str[i] == '\f'))
// 		i++;
// 	if (str[i] == '+')
// 		i++;
// 	else if (str[i] == '-')
// 	{
// 		isneg *= -1;
// 		i++;
// 	}
// 	while (str[i] >= '0' && str[i] <= '9')
// 	{
// 		num = (num * 10) + (str[i] - '0');
// 		i++;
// 	}
// 	return (num * isneg);
// }
