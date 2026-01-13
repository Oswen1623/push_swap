/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lucinguy <lucinguy@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/12 12:35:06 by lucinguy          #+#    #+#             */
/*   Updated: 2026/01/13 15:51:32 by lucinguy         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include <limits.h>
# include <stdarg.h>
# include <stdlib.h>
# include <unistd.h>

// Push swap
/// Principal

// Algorithm

/// Utils
long	ft_atol(const char *str);

// Printf
/// Principal

int		ft_printf(const char *format, ...);

/// Checktype

int		checktype(char c, va_list args, int fd);

/// Utils

size_t	ft_putchar_fd_pf(char c, int fd);
size_t	ft_putstr_fd_pf(char *s, int fd);

/// Conv

int		ft_putnbr_t_fd(long n, int fd);
int		ft_putnbr_base_x(unsigned long n, int uppercase, int fd);
int		ft_putpointer(unsigned long n, int fd);

// Utils
char	**ft_split(char const *s, char c);

#endif