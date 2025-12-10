/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/10 15:25:58 by lucinguy          #+#    #+#             */
/*   Updated: 2025/12/10 18:42:19 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	main(int argc, char argv)
{
	t_stack_node	a;
	t_stack_node	b;

	a = NULL;
	b = NULL;
	if ((argc == 1) || (argc == 2 && !argv[1][0]))
		return (1);
	// each argument is an int to be sorted, and stocked in the stack
}
