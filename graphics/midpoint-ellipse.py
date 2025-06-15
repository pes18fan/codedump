import pygame
import sys
import math

WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Midpoint Ellipse Algorithm")
clock = pygame.time.Clock()


def get_ellipse_point_parametric(r_x, r_y, speed=0.01):
    angle = 0
    while True:
        x = int(r_x * math.cos(angle))
        y = int(r_y * math.sin(angle))

        yield (x, y)

        angle += speed
        if angle >= 2 * math.pi:
            angle -= 2 * math.pi


def draw_ellipse(x_c, y_c, r_x, r_y, color=WHITE):
    x, y = 0, r_y
    screen.set_at((x + x_c, y + y_c), color)
    screen.set_at((x + x_c, -y + y_c), color)

    p_1 = r_y**2 + 0.25 * r_x**2 - r_x**2 * r_y

    while 2 * r_y**2 * x <= 2 * r_x**2 * y:
        if p_1 < 0:
            x += 1
            p_1 += 2 * r_y**2 * x + r_y**2
        else:
            x += 1
            y -= 1
            p_1 += 2 * r_y**2 * x - 2 * r_x**2 * y + r_y**2

        screen.set_at((x + x_c, y + y_c), color)
        screen.set_at((x + x_c, -y + y_c), color)
        screen.set_at((-x + x_c, -y + y_c), color)
        screen.set_at((-x + x_c, y + y_c), color)

    p_2 = r_y**2 * (x + 0.5)**2 + r_x**2 * (y - 1)**2 - r_x**2 * r_y**2

    while y != 0:
        if p_2 > 0:
            y -= 1
            p_2 += -2 * r_x**2 * y + r_x**2
        else:
            x += 1
            y -= 1
            p_2 += 2 * r_y**2 * x - 2 * r_x**2 * y + r_x**2

        screen.set_at((x + x_c, y + y_c), color)
        screen.set_at((x + x_c, -y + y_c), color)
        screen.set_at((-x + x_c, -y + y_c), color)
        screen.set_at((-x + x_c, y + y_c), color)


def main():
    for (x, y) in get_ellipse_point_parametric(300, 200):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        screen.fill(BLACK)

        # Basic animation of a round object rotating on an elliptical path
        # Reminiscent of a planet moving on its orbit

        # Orbit
        draw_ellipse(400, 300, 300, 200)

        # Planet
        draw_ellipse(x + 400, y + 300, 20, 20)

        pygame.display.flip()

        clock.tick(60)


if __name__ == "__main__":
    main()
