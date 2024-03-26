from faker import Faker
import random
from json import dump

fake = Faker()


def generate_fake_job():
    id = fake.uuid4()
    title = fake.job()
    company = fake.company()
    description = fake.text()
    image = fake.image_url()
    location = fake.address()
    employmentType = random.choice(["Full-time", "Part-time", "Contract", "Internship"])
    datePosted = fake.date()
    salaryRange = fake.random_element(
        elements=("30k - 50k", "50k - 80k", "80k - 100k", "100k+")
    )

    return {
        "id": id,
        "title": title,
        "company": company,
        "description": description,
        "image": image,
        "location": location,
        "employmentType": employmentType,
        "datePosted": datePosted,
        "salaryRange": salaryRange,
    }


def generate_fake_jobs(num_jobs):
    jobs = []
    for _ in range(num_jobs):
        jobs.append(generate_fake_job())
    return jobs


def get_popular_jobs():
    num_jobs = 30  # Change this to generate desired number of fake jobs
    fake_jobs = generate_fake_jobs(num_jobs)
    return fake_jobs


def get_nearby_jobs():
    num_jobs = 30  # Change this to generate desired number of fake jobs
    fake_jobs = generate_fake_jobs(num_jobs)
    return fake_jobs


# if __name__ == "__main__":
# app.run(host="0.0.0.0", debug=True)
with open("assets/popular-jobs.json", "w") as f:
    dump(get_popular_jobs(), f)
with open("assets/nearby-jobs.json", "w") as f:
    dump(get_nearby_jobs(), f)
