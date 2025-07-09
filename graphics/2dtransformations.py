import pygame, sys
import numpy as np

WIDTH, HEIGHT = 800, 600
WHITE = (255, 255, 255)
RED = (200, 0, 100)
GREEN = (100, 200, 0)
BLUE = (0, 100, 200)
BLACK = (0, 0, 0)

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("2D Translation")
clock = pygame.time.Clock()

def translate(coordinate, tx, ty):
    x, y = coordinate
    initial = np.array([x, y, 1])
    translation = np.array([
        [1, 0, tx],
        [0, 1, ty],
        [0, 0, 1]
    ])
    result = np.matmul(translation, initial)

    x_new = int(result[0])
    y_new = int(result[1])
    return (x_new, y_new)

# Scale relative to origin
def scale(coordinate, sx, sy):
    x, y = coordinate
    initial = np.array([x, y, 1])
    transformation = np.array([
        [sx, 0, 0],
        [0, sy, 0],
        [0, 0, 1]
    ])
    result = np.matmul(transformation, initial)

    x_new = int(result[0])
    y_new = int(result[1])
    return (x_new, y_new)


# Rotate relative to provided center
# Positive angle = anticlockwise, negative angle = clockwise
def rotate(coordinate, theta, center=(0, 0)):
    x_centered, y_centered = translate(coordinate, -center[0], -center[1])

    initial = np.array([x_centered, y_centered, 1])
    transformation = np.array([
        [np.cos(theta), -np.sin(theta), 0],
        [np.sin(theta), np.cos(theta), 0],
        [0, 0, 1]
    ])
    result = np.matmul(transformation, initial)

    x_new, y_new = translate((result[0], result[1]), center[0], center[1])
    return (x_new, y_new)

def main():
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
        
        screen.fill(BLACK)

        start = (400, 200)
        end = (400, 300)
        angle = np.pi / 2
        tx, ty = 50, -50
        sx, sy = 1.5, 1.5
        center = (400, 300)

        pygame.draw.line(screen, WHITE, start, end)
        pygame.draw.line(screen, RED, translate(start, tx, ty), translate(end, tx, ty))
        pygame.draw.line(screen, GREEN, scale(start, sx, sy), scale(end, sx, sy))
        pygame.draw.line(screen, BLUE, rotate(start, angle, center), rotate(end, angle, center))

        pygame.display.flip()


if __name__ == "__main__":
    main()