from flask import render_template, request, flash, redirect


from .app import app, db
from .modeles.donnees import Edition, Authorite, Exemplaire, Bibliothecae, Provenance
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

    issues = Edition.query.order_by(Edition.edition_short_title).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_issues.html", nom="Erasmus", issues=issues, page=page)

@app.route("/edition/<int:edition_id>")

def issue(edition_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_issue = Edition.query.get(edition_id)
    exemplaires=unique_issue.exemplaire
    citations=unique_issue.citation
    references=unique_issue.reference

    return render_template("pages/issue.html", nom="Erasmus", issue=unique_issue, exemplaires=exemplaires, citations=citations, references=references)





@app.route("/bibliotheque/<string:bibliothecae_id>")
def library(bibliothecae_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_bibliotheque = Bibliothecae.query.get(bibliothecae_id)


    return render_template("pages/bibliotheque.html", nom="Erasmus", bibliotheque=unique_bibliotheque)


@app.route("/exemplaire/<int:exemplaire_id>")
def exemplar(exemplaire_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_exemplar = Exemplaire.query.get(exemplaire_id)
    edition_exemplaire = Edition.query.get(unique_exemplar.exemplaire_edition_id)

    return render_template("pages/exemplaires.html", nom="Erasmus", exemplar=unique_exemplar, edition=edition_exemplaire)


@app.route("/creer_edition", methods=["GET", "POST"])

def creer_edition():
    editions = Edition.query.order_by(Edition.edition_cleanDate.asc()).all()
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """
    if request.method == "POST":
        statut, donnees = Edition.creer_edition(
            short_title=request.form.get("short_title", None),
            title_notes=request.form.get("title_notes"),
            uniform_title=request.form.get("uniform_title"),
            full_title=request.form.get("parallel_title"),
            author_first=request.form.get("author_first", None),
            author_second=request.form.get("lien"),
            publisher=request.form.get("publisher", None),
            prefaceur=request.form.get("prefaceur"),
            translator=request.form.get("translator", None),
            dateInferred=request.form.get("dateInferred", None),
            displayDate=request.form.get("displayDate", None),
            cleanDate=request.form.get("cleanDate", None),
            languages=request.form.get("languages", None),
            placeInferred=request.form.get("placeInferred", None),
            place1=request.form.get("place", None),
            place2=request.form.get("place2", None),
            placeClean=request.form.get("placeClean", None),
            country=request.form.get("country", None),
            format=request.form.get("format"),
            formatNotes=request.form.get("formatNotes"),
            imprint=request.form.get("imprint", None),
            signatures=request.form.get("sigantures"),
            PpFf=request.form.get("PpFf"),
            remarks=request.form.get("remarks"),
            colophon=request.form.get("colophon"),
            illustrated=request.form.get("illustrated"),
            typographicMaterial=request.form.get("typographicMaterial"),
            sheets=request.form.get("sheets"),
            typeNotes=request.form.get("typeNotes"),
            fb=request.form.get("fb"),
            correct=request.form.get("correct"),
            locFingerprints=request.form.get("locFingerprints"),
            stcnFingerprints=request.form.get("stcnFingerprints"),
            tpt=request.form.get("tpt"),
            notes=request.form.get("notes"),
            printer=request.form.get("printer"),
            urlImage=request.form.get("urlImage"),
            class0=request.form.get("class0", None),
            class1=request.form.get("class1", None),
            class2=request.form.get("class2", None),
            internal=request.form.get("internal"),
            digital=request.form.get("digital", None),
            fulltext=request.form.get("fulltext", None),
            tpimage=request.form.get("tpimage", None),
            privelege=request.form.get("privelege", None),
            dedication=request.form.get("dedication", None),
            reference=request.form.get("reference", None),
            citation=request.form.get("citation", None),


        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/creer_edition.html", editions=editions)
    else:
        return render_template("pages/creer_edition.html", editions=editions)

@app.route("/ajout_exemplaire/<int:identifier>", methods=["GET", "POST"])

def ajout_exemplaire(identifier):
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """
    edition = Edition.query.get(identifier)
    bibliotheques = Bibliothecae.query.all()
    if request.method == "GET":
        bibliotheques = Bibliothecae.query.all()
        edition = Edition.query.get(identifier)

        return render_template("pages/ajout_exemplaire.html", bibliotheques=bibliotheques, edition=edition)


    if request.method == "POST":
        bibliotheques = Bibliothecae.query.all()
        edition = Edition.query.get(identifier)
        statut, donnees = Exemplaire.ajout_exemplaire(
            pressmark=request.form.get("pressmark"),
            hauteur=request.form.get('hauteur'),
            variantesEdition=request.form.get('variantesEdition'),
            digitalURL=request.form.get('digitalURL'),
            etatMateriel=request.form.get('etatMateriel'),
            notes=request.form.get('notes'),
            provenances=request.form.get('provenances'),
            locFingerprint=request.form.get('locFingerprint'),
            stcnFingerprint=request.form.get('stcnFingerprint'),
            annotationManuscrite=request.form.get('annotationManuscrite'),
            largeur=request.form.get('largeur'),
            recueilFactice=request.form.get('recueilFactice'),
            reliure=request.form.get('reliure'),
            reliureXVI=request.form.get('reliureXVI'),
            edition_id=identifier,
            bibliothecae_id=request.form.get('library'),
    )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_exemplaire.html", bibliotheques=bibliotheques, edition=edition)
    else:
        return render_template("pages/ajout_exemplaire.html", bibliotheques=bibliotheques, edition=edition)

@app.route("/ajout_provenance/<int:identifier>", methods=["GET", "POST"])

def ajout_provenance(identifier):

    if request.method == "GET":
        exemplaire = Exemplaire.query.get(identifier)

        return render_template("pages/ajout_provenance.html",  exemplaire=exemplaire)

    if request.method == "POST":
        exemplaire = Exemplaire.query.get(identifier)
        statut, donnees = Provenance.ajout_provenance(
            exlibris=request.form.get('exlibris'),
            exdono=request.form.get('exdono'),
            envoi=request.form.get('envoi'),
            notesManuscrites=request.form.get('notesManuscrites'),
            armesPeintes=request.form.get('armesPeintes'),
            restitue=request.form.get('restitue'),
            mentionEntree=request.form.get('mentionEntree'),
            estampillesCachets=request.form.get('estampillesCachets'),
            reliure_provenance=request.form.get('reliure_provenance'),
            possesseur=request.form.get('possesseur'),
            exemplaire_id=identifier,
            possesseur_formeRejetee=request.form.get('possesseur_formeRejetee'),

    )
        if statut is True:
            flash("Enregistrement effectué", "success", exemplaire=exemplaire)
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_provenance.html", exemplaire=exemplaire)
    else:
        return render_template("pages/ajout_provenance.html")


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
            Edition.edition_full_title.like("%{}%".format(motclef)),
            Edition.edition_uniform_title.like("%{}%".format(motclef)),
            Edition.edition_author_first.like("%{}%".format(motclef)),
            Edition.edition_author_second.like("%{}%".format(motclef)),
            Edition.edition_country.like("%{}%".format(motclef)),
            Edition.edition_place1.like("%{}%".format(motclef)))

        ).order_by(Edition.edition_short_title.asc()).paginate(page=page, per_page=EDITION_PAR_PAGE)
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