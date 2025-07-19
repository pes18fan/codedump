import pygame
import sys
import numpy as np

WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
RED = (200, 0, 100)
GREEN = (100, 200, 0)
BLUE = (0, 100, 200)
BLACK = (0, 0, 0)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("3D Transformation")
clock = pygame.time.Clock()


def project(point, perspective=1000):
    x, y, z = point
    factor = perspective / (perspective + z)
    return int(x * factor), int(y * factor)


def draw_line_bresenham(starting, ending):
    x1, y1 = starting
    x2, y2 = ending
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


def translate(coord_matrix, tx, ty, tz):
    translation = np.array([
        [1, 0, 0, tx],
        [0, 1, 0, ty],
        [0, 0, 1, tz],
        [0, 0, 0, 1]
    ])
    result = np.matmul(translation, coord_matrix)

    return result


def rotate_about_x(coord_matrix, theta, center=(400, 300, 100)):
    tx, ty, tz = center
    coord_matrix_centered = translate(coord_matrix, -tx, -ty, -tz)
    transformation = np.array([
        [1, 0, 0, 0],
        [0, np.cos(theta), -np.sin(theta), 0],
        [0, np.sin(theta), np.cos(theta), 0],
        [0, 0, 0, 1],
    ])

    rotated = np.matmul(transformation, coord_matrix_centered)
    result = translate(rotated, tx, ty, tz)
    return result


def main():
    vertices = np.array([
        [350, 450, 450, 350, 350, 450, 450, 350],
        [250, 250, 350, 350, 250, 250, 350, 350],
        [50, 50, 50, 50, 150, 150, 150, 150],
        [1, 1, 1, 1, 1, 1, 1, 1]
    ])

    edges = [
        (0, 1), (1, 2), (2, 3), (3, 0),  # bottom face
        (4, 5), (5, 6), (6, 7), (7, 4),  # top face
        (0, 4), (1, 5), (2, 6), (3, 7),  # verticals
    ]

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

        screen.fill(BLACK)

        vertices = rotate_about_x(vertices, 0.001)

        for i, j in edges:
            p1 = (vertices[0][i], vertices[1][i], vertices[2][i])
            p2 = (vertices[0][j], vertices[1][j], vertices[2][j])
            draw_line_bresenham(project(p1), project(p2))

        pygame.display.flip()


if __name__ == "__main__":
    main()
