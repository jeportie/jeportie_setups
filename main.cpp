/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.cpp                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/15 10:50:07 by jeportie          #+#    #+#             */
/*   Updated: 2025/03/15 12:30:37 by jeportie         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <iostream>

void ft_putstr(const char *str)
{
    std::cout << str << std::endl;
    for (size_t i = 0; i < 5; i++)
    {
        std::cout << "My name is Jerome " << i << std::endl;
    }
}

int main(void)
{
    ft_putstr("Hello, World");
    return (0);
}
