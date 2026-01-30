/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   b_to_a.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/26 15:32:55 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/30 18:42:41 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	target_b(t_stack_node *a, t_stack_node *b)
{
	t_stack_node	*current;
	t_stack_node	*target_node;
	long			best_match_index;

	while (b)
	{
		best_match_index = LONG_MAX;
		current = a;
		while (current)
		{
			if (current->nbr > b->nbr && current->nbr < best_match_index)
			{
				best_match_index = current->nbr;
				target_node = current;
			}
			current = current->next;
		}
		if (best_match_index == LONG_MAX)
			b->target_node = find_min(a);
		else
			b->target_node = target_node;
		b = b->next;
	}
}

void	init_b_nodes(t_stack_node *a, t_stack_node *b)
{
	current_index(a);
	current_index(b);
	target_b(a, b);
}
