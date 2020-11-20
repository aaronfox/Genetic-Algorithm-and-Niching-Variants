import random
import math


# found all of this from https://hackernoon.com/genetic-algorithms-explained-a-python-implementation-sd4w374i
# By Luiz Rosa


def generate_population(size, x_boundaries):#, y_boundaries):
    lower_x_boundary, upper_x_boundary = x_boundaries

    population = []
    for i in range(size):
        individual = {
            "x": random.uniform(lower_x_boundary, upper_x_boundary),
        }
        population.append(individual)

    return population


def apply_function(individual):
    x = individual["x"]
    m1 = math.sin(5*math.pi*x) ** 6
    return m1


def choice_by_roulette(sorted_population, fitness_sum):
    offset = 0
    normalized_fitness_sum = fitness_sum

    lowest_fitness = apply_function(sorted_population[0])
    if lowest_fitness < 0:
        offset = -lowest_fitness
        normalized_fitness_sum += offset * len(sorted_population)

    draw = random.uniform(0, 1)

    accumulated = 0
    for individual in sorted_population:
        fitness = apply_function(individual) + offset
        probability = fitness / normalized_fitness_sum
        accumulated += probability

        if draw <= accumulated:
            return individual


def sort_population_by_fitness(population):
    return sorted(population, key=apply_function)


def crossover(individual_a, individual_b):
    xa = individual_a["x"]

    xb = individual_b["x"]

    return {"x": (xa + xb) / 2}


def mutate(individual):
    next_x = individual["x"] + random.uniform(-0.05, 0.05)

    lower_boundary, upper_boundary = (-4, 4)

    # Guarantee we keep inside boundaries
    next_x = min(max(next_x, lower_boundary), upper_boundary)

    return {"x": next_x}

def make_next_generation(previous_population):
    next_generation = []
    sorted_by_fitness_population = sort_population_by_fitness(
        previous_population)
    population_size = len(previous_population)
    fitness_sum = sum(apply_function(individual) for individual in population)

    for i in range(population_size):
        first_choice = choice_by_roulette(
            sorted_by_fitness_population, fitness_sum)
        second_choice = choice_by_roulette(
            sorted_by_fitness_population, fitness_sum)

        individual = crossover(first_choice, second_choice)
        individual = mutate(individual)
        next_generation.append(individual)

    return next_generation


generations = 100

population = generate_population(
    size=50, x_boundaries=(0, 1))

i = 1
while True:
    print(f" GENERATION {i}")

    for individual in population:
        print(individual, apply_function(individual))

    if i == generations:
        break

    i += 1

    population = make_next_generation(population)

best_individual = sort_population_by_fitness(population)[-1]
print("\n FINAL RESULT")
print(best_individual, apply_function(best_individual))
