setup:
	python3 -m venv ~/.notebooks

install:
	pip install -r requirements.txt

test:
	#PYTHONPATH=. && pytest -vv --cov=paws --cov=spot-price-ml tests/*.py
	#PYTHONPATH=. && py.test --nbval-lax EffectivePython/*.ipynb
	
lint:
	pylint --disable=R,C funclib

all: install lint test