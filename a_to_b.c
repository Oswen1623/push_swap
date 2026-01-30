/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   a_to_b.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/26 15:33:05 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/27 15:33:03 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

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

static void	cost_a(t_stack_node *a, t_stack_node *b)
{
	int	len_a;
	int	len_b;

	len_a = stack_len(a);
	len_b = stack_len(b);
	while (a)
	{
		a->push_cost = a->index;
		if (!(a->above_median))
			a->push_cost = len_a - (a->index);
		if (a->target_node->above_median)
			a->push_cost += a->target_node->index;
		else
			a->push_cost += len_b - (a->target_node->index);
		a = a->next;
	}
}

void	set_cheapest(t_stack_node *stack)
{
	long			cheapest_value;
	t_stack_node	*cheapest_node;

	if (!stack)
		return ;
	cheapest_value = LONG_MAX;
	while (stack)
	{
		if (stack->push_cost < cheapest_value)
		{
			cheapest_value = stack->push_cost;
			cheapest_node = stack;
		}
		stack = stack->next;
	}
	cheapest_node->cheapest = true;
}

void	init_a_nodes(t_stack_node *a, t_stack_node *b)
{
	index(a);
	index(b);
	target_a(a, b);
	cost_a(a, b);
	set_cheapest(a);
}
