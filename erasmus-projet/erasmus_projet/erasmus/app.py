from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
import os
from .constantes import SECRET_KEY
from .constantes import CONFIG

chemin_actuel = os.path.dirname(os.path.abspath(__file__))
templates = os.path.join(chemin_actuel, "templates")
statics = os.path.join(chemin_actuel, "static")


# On initie l'extension
db = SQLAlchemy()
# On met en place la gestion d'utilisateur-rice-s
login = LoginManager()

app = Flask(
    __name__,
    template_folder=templates,
    static_folder=statics
)
# On configure le secret
app.config['SECRET_KEY'] = SECRET_KEY
# On configure la base de données
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://erasmus_user:password@localhost/erasmus'
# On initie l'extension
db = SQLAlchemy(app)

# On met en place la gestion d'utilisateur-rice-s
login = LoginManager(app)


from . import routes

def config_app(config_name="test"):
    """ Create the application """
    app.config.from_object(CONFIG[config_name])

    # Set up extensions
    db.init_app(app)
    # assets_env = Environment(app)
    login.init_app(app)

    # Register Jinja template functions

    return app

#from .routes import accueil, issue, library, exemplar