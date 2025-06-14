import pygame
import sys

WIDTH, HEIGHT = 1000, 800
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

YELLOW = (180, 150, 0)
BROWN = (180, 150, 120)
LIGHT_BROWN = (200, 150, 100)
CREAM = (210, 190, 190)
BLUISH = (20, 100, 180)
LIGHT_BLUE = (120, 240, 240)
DARK_BLUE = (50, 50, 240)
RUSTY_RED = (200, 100, 80)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Midpoint Circle Algorithm")


def draw_circle(x_c, y_c, r, color=WHITE, fill=False):
    x, y = 0, r
    p = 1 - r

    while x <= y:
        screen.set_at((x + x_c, y + y_c), color)
        screen.set_at((x + x_c, -y + y_c), color)
        screen.set_at((y + x_c, -x + y_c), color)
        screen.set_at((-y + x_c, -x + y_c), color)
        screen.set_at((-x + x_c, -y + y_c), color)
        screen.set_at((-x + x_c, y + y_c), color)
        screen.set_at((-y + x_c, x + y_c), color)
        screen.set_at((y + x_c, x + y_c), color)

        if p < 0:
            x += 1
            p += 2 * x + 1
        else:
            x += 1
            y -= 1
            p += 2 * x - 2 * y + 1

    if fill:
        for i in range(r):
            draw_circle(x_c, y_c, i, color)


def main():
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        screen.fill(BLACK)

        # Drawing a (very) roughly to-scale solar system

        # sun
        draw_circle(WIDTH // 2, HEIGHT // 2, 50, color=YELLOW, fill=True)

        # mercury
        draw_circle(WIDTH // 2, HEIGHT // 2, 100)
        draw_circle(WIDTH // 2 + 100, HEIGHT // 2, 4, color=BROWN, fill=True)

        # venus
        draw_circle(WIDTH // 2, HEIGHT // 2, 120)
        draw_circle(WIDTH // 2, HEIGHT // 2 + 120, 6, color=LIGHT_BROWN, fill=True)

        # earth
        draw_circle(WIDTH // 2, HEIGHT // 2, 140)
        draw_circle(WIDTH // 2 + 140, HEIGHT // 2, 6, color=BLUISH, fill=True)

        # mars
        draw_circle(WIDTH // 2, HEIGHT // 2, 160)
        draw_circle(WIDTH // 2, HEIGHT // 2 - 160, 5, color=RUSTY_RED, fill=True)

        # jupiter
        draw_circle(WIDTH // 2, HEIGHT // 2, 220)
        draw_circle(WIDTH // 2 - 220, HEIGHT // 2, 13, color=LIGHT_BROWN, fill=True)

        # saturn
        draw_circle(WIDTH // 2, HEIGHT // 2, 260)
        draw_circle(WIDTH // 2 + 260, HEIGHT // 2, 12, color=CREAM, fill=True)

        # uranus
        draw_circle(WIDTH // 2, HEIGHT // 2, 310)
        draw_circle(WIDTH // 2, HEIGHT // 2 + 310, 10, color=LIGHT_BLUE, fill=True)

        # neptune
        draw_circle(WIDTH // 2, HEIGHT // 2, 370)
        draw_circle(WIDTH // 2, HEIGHT // 2 - 370, 9, color=DARK_BLUE, fill=True)

        pygame.display.flip()


if __name__ == "__main__":
    main()
