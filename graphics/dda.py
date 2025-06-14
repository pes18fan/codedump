import pygame
import sys

WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("DDA Line Algorithm")


def draw_line_dda(x1, y1, x2, y2):
    dx, dy = x2 - x1, y2 - y1

    step = 0
    if abs(dx) > abs(dy):
        step = dx
    else:
        step = dy

    x_inc = dx / step
    y_inc = dy / step

    x, y = x1, y1
    screen.set_at((x, y), WHITE)

    while x != x2 or y != y2:
        x += x_inc
        y += y_inc
        screen.set_at((round(x), round(y)), WHITE)


def main():
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        screen.fill(BLACK)

        # Drawing a little house

        # vertical sides
        draw_line_dda(100, 200, 100, 500)   # left
        draw_line_dda(700, 200, 700, 500)   # right

        # horizontal lines
        draw_line_dda(100, 200, 700, 200)   # top
        draw_line_dda(100, 500, 700, 500)   # bottom

        # door
        draw_line_dda(350, 300, 350, 500)   # left vertical line
        draw_line_dda(450, 300, 450, 500)   # right vertical line
        draw_line_dda(350, 300, 450, 300)   # top line

        # roof
        draw_line_dda(100, 200, 400, 50)
        draw_line_dda(400, 50, 700, 200)

        pygame.display.flip()


if __name__ == "__main__":
    main()
