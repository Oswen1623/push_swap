/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   a_to_b.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/26 15:33:05 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/26 18:15:44 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

void	index(t_stack_node *stack)
{
	int	i;
	int	median;

	i = 0;
	if (!stack)
		return ;
	median = stack_len(stack) / 2;
	while (stack)
	{
		stack->index = i;
		if (i <= median)
			stack->above_median = true;
		else
			stack->above_median = false;
		stack = stack->next;
		++i;
	}
}

static void	target_a(t_stack_node *a, t_stack_node *b)
{
	t_stack_node	*current;
	t_stack_node	*target_node;
	long			best_match_index;

	while (a)
	{
		best_match_index = LONG_MIN;
		current = b;
		while (current)
		{
			if (current->nbr < a->nbr && current->nbr > best_match_index)
			{
				best_match_index = current->nbr;
				target_node = current;
			}
			current = current->next;
		}
		if (best_match_index == LONG_MIN)
			a->target_node = find_max(b);
		else
			a->target_node = target_node;
		a = a->next;
	}
}
