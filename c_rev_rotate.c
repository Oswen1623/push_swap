/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   c_rev_rotate.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/01/27 16:30:43 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/28 11:34:37 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	rev_rotate(t_stack_node **stack)
{
	t_stack_node	*last;

	if (!*stack || !(*stack)->next)
		return ;
	last = find_last(*stack);
	last->prev->next = NULL;
	last->next = *stack;
	last->prev = NULL;
	*stack = last;
	last->next->prev = last;
}

void	rra(t_stack_node **a, bool print)
{
	rev_rotate(a);
	if (!print)
		ft_printf("rra\n");
}

void	rrb(t_stack_node **b, bool print)
{
	rev_rotate(b);
	if (!print)
		ft_printf("rrb\n");
}

void	rrr(t_stack_node **a, t_stack_node **b, bool print)
{
	rev_rotate(a);
	rev_rotate(b);
	if (!print)
		ft_printf("rrr\n");
}
