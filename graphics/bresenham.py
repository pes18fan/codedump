import pygame
import sys

WIDTH, HEIGHT = 600, 800
WHITE = (255, 255, 255)
DARK_GREEN = (50, 125, 10)
BLACK = (0, 0, 0)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Bresenham's Line Algorithm")


def draw_line_bresenham(x1, y1, x2, y2):
    dx, dy = abs(x2 - x1), abs(y2 - y1)

    if x2 > x1:
        lx = 1
    else:
        lx = -1

    if y2 > y1:
        ly = 1
    else:
        ly = -1

    x, y = x1, y1
    screen.set_at((x, y), WHITE)

    if abs(dx) > abs(dy):
        p = 2 * dy - dx

        for _ in range(abs(dx)):
            if p < 0:
                x += lx
                p += 2 * dy
            else:
                x += lx
                y += ly
                p += 2 * dy - 2 * dx

            screen.set_at((x, y), WHITE)

    else:
        p = 2 * dx - dy

        for _ in range(abs(dy)):
            if p < 0:
                y += ly
                p += 2 * dx
            else:
                y += ly
                x += lx
                p += 2 * dx - 2 * dy

            screen.set_at((x, y), WHITE)


def main():
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        screen.fill(DARK_GREEN)

        # Drawing a football pitch

        # horizontal boundaries
        draw_line_bresenham(50, 50, 550, 50)
        draw_line_bresenham(50, 750, 550, 750)

        # vertical boundaries
        draw_line_bresenham(50, 50, 50, 750)
        draw_line_bresenham(550, 50, 550, 750)

        # halfway line
        draw_line_bresenham(50, 400, 550, 400)

        # penalty region (top)
        draw_line_bresenham(200, 150, 400, 150)
        draw_line_bresenham(200, 50, 200, 150)
        draw_line_bresenham(400, 50, 400, 150)

        # penalty region (bottom)
        draw_line_bresenham(200, 650, 400, 650)
        draw_line_bresenham(200, 750, 200, 650)
        draw_line_bresenham(400, 750, 400, 650)

        # thingy inside penalty region (top)
        draw_line_bresenham(250, 100, 350, 100)
        draw_line_bresenham(250, 50, 250, 100)
        draw_line_bresenham(350, 50, 350, 100)

        # thingy inside penalty region (bottom)
        draw_line_bresenham(250, 700, 350, 700)
        draw_line_bresenham(250, 750, 250, 700)
        draw_line_bresenham(350, 750, 350, 700)

        pygame.display.flip()


if __name__ == "__main__":
    main()
