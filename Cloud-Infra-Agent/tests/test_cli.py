import agent
from agent.cli import main


def test_version():
    assert agent.__version__ == "0.1.0"


def test_cli_version_exits_zero():
    try:
        main(["--version"])
    except SystemExit as exc:
        assert exc.code == 0
