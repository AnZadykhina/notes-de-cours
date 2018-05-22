from flask import render_template, request, flash, redirect


from .app import app, db
from .modeles.donnees import Edition, Authorite, Exemplaire, Bibliothecae, Collator
from .constantes import EDITION_PAR_PAGE


@app.route("/")
def accueil():

    return render_template("pages/accueil.html", nom="Erasmus")

@app.route("/authorite/<int:authorite_id> ")
def author(authorite_id):
   unique_author = Authorite.query.get(authorite_id)

   return render_template("pages/author.html", nom="Erasmus", author=unique_author)

@app.route("/auteurs")
def all_authors():
    """ Route permettant l'affichage d'une page avec touts commentaires ajoutés
    :return: page html avec une liste de commentaires
    """
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    authors = Authorite.query.order_by(Authorite.authorite_id).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_authors.html", nom="Erasmus", authors=authors, page=page)

@app.route("/bibliotheques")
def all_libraries():
    """ Route permettant l'affichage d'une page avec touts commentaires ajoutés
    :return: page html avec une liste de commentaires
    """
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    libraries = Bibliothecae.query.order_by(Bibliothecae.bibliothecae_library).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_libraries.html", nom="Erasmus", libraries=libraries, page=page)

@app.route("/editions")
def all_issues():
    """ Route permettant l'affichage d'une page avec touts commentaires ajoutés
    :return: page html avec une liste de commentaires
    """
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    issues = Edition.query.order_by(Edition.edition_id).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_issues.html", nom="Erasmus", issues=issues, page=page)

@app.route("/edition/<int:edition_id>")
def issue(edition_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_issue = Edition.query.get(edition_id)

    return render_template("pages/issue.html", nom="Erasmus", issue=unique_issue, col=col)

@app.route("/bibliotheque/<int:bibliotheque_id>")
def library(bibliothecae_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_bibliotheque = Bibliothecae.query.get(bibliothecae_id)

    return render_template("pages/bibliotheque.html", nom="Erasmus", bibliotheque=unique_bibliotheque)


@app.route("/exemplaire/<int:exemplaire_id>")
def exemplar(exemplaire_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_exemplar = Exemplaire.query.get(exemplaire_id)

    return render_template("pages/exemplaires.html", nom="Erasmus", exemplar=unique_exemplar)

@app.route("/exemplaires")
def all_exemplars():
    """ Route permettant l'affichage d'une page avec touts commentaires ajoutés
    :return: page html avec une liste de commentaires
    """
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    exemplars = Exemplaire.query.order_by(Exemplaire.exemplaire_id).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_exemplar.html", nom="Erasmus", exemplars=exemplars, page=page)

@app.route("/creer_edition", methods=["GET", "POST"])

def creer_edition():
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """
    if request.method == "POST":
        statut, donnees = Edition.creer_edition(
            short_title=request.form.get("short_title", None),
            author_first=request.form.get("author_first", None),
            author_second=request.form.get("lien"),
            publisher=request.form.get("publisher", None),
            translator=request.form.get("translator", None),
            dateInferred=request.form.get("dateInferred", None),
            displayDate=request.form.get("displayDate", None),
            cleanDate=request.form.get("cleanDate", None),
            languages=request.form.get("languages", None),
            placeInferred=request.form.get("placeInferred", None),
            place=request.form.get("place", None),
            placeClean=request.form.get("placeClean", None),
            country=request.form.get("country", None),
            imprint=request.form.get("imprint", None),
            class0=request.form.get("class0", None),
            class1=request.form.get("class1", None),
            class2=request.form.get("class2", None),
            digital=request.form.get("digital", None),
            fulltext=request.form.get("fulltext", None),
            tpimage=request.form.get("tpimage", None),
            privelege=request.form.get("privelege", None),
            dedication=request.form.get("dedication", None),
            permission=request.form.get("permission", None),
            reference=request.form.get("reference", None),
            location=request.form.get("location", None),
            citation=request.form.get("citation", None),
            collator = request.form.get("citation", None),


        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/creer_edition.html")
    else:
        return render_template("pages/creer_edition.html")

@app.route("/recherche")
def recherche():
    """ Route permettant la recherche plein-texte
    """
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])
    motclef = request.args.get("keyword", None)
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    # On crée une liste vide de résultat (qui restera vide par défaut
    #   si on n'a pas de mot clé)
    resultats = []

    # On fait de même pour le titre de la page
    titre = "Recherche"
    if motclef:
        resultats = Edition.query.filter(db.or_(
            Edition.edition_short_title.like("%{}%".format(motclef)),
            Edition.edition_title.like("%{}%".format(motclef)),
            Edition.edition_parallel_title.like("%{}%".format(motclef)),
            Edition.edition_uniform_title.like("%{}%".format(motclef)),
            Edition.edition_author_first.like("%{}%".format(motclef)),
            Edition.edition_author_second.like("%{}%".format(motclef)),
            Edition.edition_country.like("%{}%".format(motclef)))

        ).paginate(page=page, per_page=EDITION_PAR_PAGE)
        titre = "Résultat pour la recherche `" + motclef + "`"

    return render_template(
        "pages/recherche.html",
        resultats=resultats,
        titre=titre,
        keyword=motclef
    )

@app.route("/browse")
def browse():
    """ Route permettant la recherche plein-texte
    """
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    resultats = Edition.query.paginate(page=page, per_page=EDITION_PAR_PAGE)

    return render_template(
        "pages/browse.html",
        resultats=resultats
    )