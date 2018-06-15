from flask import render_template, request, flash, redirect, url_for


from .app import app, db
from .modeles.donnees import Edition, Exemplaire, Bibliothecae, Provenance, Reference, Bibliographie, Citation
from .constantes import EDITION_PAR_PAGE


@app.route("/")
def accueil():

    return render_template("pages/accueil.html", nom="Erasmus")
"""
@app.route("/authorite/<int:authorite_id> ")
def author(authorite_id):
   unique_author = Authorite.query.get(authorite_id)

   return render_template("pages/author.html", nom="Erasmus", author=unique_author)

@app.route("/auteurs")
def all_authors():

    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    authors = Authorite.query.order_by(Authorite.authorite_id).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_authors.html", nom="Erasmus", authors=authors, page=page)"""

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

@app.route("/exemplaires_par_possesseur")
def exemplaires_par_possesseur():
    provenances=Provenance.query.order_by(Provenance.provenance_possesseur)
    return render_template("pages/exemplaires_par_possesseur.html", nom="Erasmus", provenances=provenances)

"""
@app.route("/exemplaires")
def all_exemplar():
    #Route permettant l'affichage d'une page avec touts commentaires ajoutés
    #:return: page html avec une liste de commentaires
    

    exemplars = Exemplaire.query.all()
    return render_template("pages/all_exemplar.html", nom="Erasmus", exemplars=exemplars)"""

@app.route("/edition/<int:edition_id>")

def issue(edition_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_issue = Edition.query.get(edition_id)
    exemplaires=unique_issue.exemplaire
    citations=unique_issue.citation
    references=unique_issue.reference

    return render_template("pages/issue.html", nom="Erasmus", issue=unique_issue, exemplaires=exemplaires, citations=citations, references=references)





@app.route("/bibliographies")
def all_bibliographies():
    """ Route permettant l'affichage d'une page avec touts commentaires ajoutés
    :return: page html avec une liste de commentaires
    """
    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    bibliographies = Bibliographie.query.order_by(Bibliographie.bibliographie_code).paginate(page=page, per_page=EDITION_PAR_PAGE)
    return render_template("pages/all_bibliographies.html", nom="Erasmus", bibliographies=bibliographies, page=page)

@app.route("/bibliographie/<int:bibliographie_id>")

def bibliographie(bibliographie_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_bibliographie = Bibliographie.query.get(bibliographie_id)
    references=unique_bibliographie.reference

    return render_template("pages/bibliographie.html", nom="Erasmus", bibliographie=unique_bibliographie, references=references)

@app.route("/ajout_bibliographie", methods=["GET", "POST"])

def ajout_bibliographie():
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """


    if request.method == "POST":
        statut, donnees = Bibliographie.ajout_bibliographie(
            code=request.form.get('code'),
            author=request.form.get('author'),
            bibliReference=request.form.get('bibliReference'),
            title=request.form.get('title'),
            imprint=request.form.get('imprint'),
            urlLink=request.form.get('urlLink'),
        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_bibliographie.html")
    else:
        return render_template("pages/ajout_bibliographie.html")




@app.route("/modif_bibliographie/<int:bibliographie_id>", methods=["GET", "POST"])
def modif_bibliographie(bibliographie_id):
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """
    unique_bibliographie = Bibliographie.query.get(bibliographie_id)
    if request.method == "POST":
        bibliographie = Bibliographie.query.get(bibliographie_id)
        statut, donnees = Bibliographie.modif_bibliographie(
            id=bibliographie_id,
            code=request.form.get('code'),
            author=request.form.get('author'),
            bibliReference=request.form.get('bibliReference'),
            title=request.form.get('title'),
            imprint=request.form.get('imprint'),
            urlLink=request.form.get('urlLink'),

        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('bibliographie', bibliographie_id=bibliographie.bibliographie_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_bibliographie.html")
    else:
        return render_template("pages/modif_bibliographie.html", bibliographie=unique_bibliographie)





@app.route("/bibliotheque/<string:bibliothecae_id>")
def library(bibliothecae_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_bibliotheque = Bibliothecae.query.get(bibliothecae_id)

    exemplaires = unique_bibliotheque.exemplaire
    

    return render_template("pages/bibliotheque.html", nom="Erasmus", bibliotheque=unique_bibliotheque, exemplaires=exemplaires)


@app.route("/ajout_bibliotheque", methods=["GET", "POST"])

def ajout_bibliotheque():
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """

    if request.method == "POST":
        statut, donnees = Bibliothecae.ajout_bibliotheque(
            id=request.form.get('id'),
            library=request.form.get('library'),
            adresse=request.form.get('adresse'),
            ville=request.form.get('ville'),
            pays=request.form.get('pays'),
            web=request.form.get('web')
        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_bibliotheque.html")
    else:
        return render_template("pages/ajout_bibliotheque.html")

@app.route("/modif_bibliotheque/<string:bibliothecae_id>", methods=["GET", "POST"])

def modif_bibliotheque(bibliothecae_id):
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """
    unique_bibliotheque = Bibliothecae.query.get(bibliothecae_id)
    if request.method == "POST":
        bibliotheque=Bibliothecae.query.get(bibliothecae_id)
        statut, donnees = Bibliothecae.modif_bibliotheque(
            id=bibliothecae_id,
            library=request.form.get('library'),
            adresse=request.form.get('adresse'),
            ville=request.form.get('ville'),
            pays=request.form.get('pays'),
            web=request.form.get('web')
        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('library', bibliothecae_id=bibliotheque.bibliothecae_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_bibliotheque.html")
    else:
        return render_template("pages/modif_bibliotheque.html", bibliotheque=unique_bibliotheque)



@app.route("/exemplaire/<int:exemplaire_id>")
def exemplar(exemplaire_id):
    # On a bien sûr aussi modifié le template pour refléter le changement
    unique_exemplar = Exemplaire.query.get(exemplaire_id)
    edition_exemplaire = Edition.query.get(unique_exemplar.exemplaire_edition_id)
    provenances=unique_exemplar.provenance

    return render_template("pages/exemplaires.html", nom="Erasmus", exemplar=unique_exemplar, edition=edition_exemplaire, provenances=provenances)


@app.route("/creer_edition", methods=["GET", "POST"])

def creer_edition():
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """
    dates = list(range(1450, 1605, 1))

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
            nomRejete=request.form.get("nomRejete", None),
            dateInferred=request.form.get("dateInferred", None),
            displayDate=request.form.get("displayDate", None),
            cleanDate=request.form.get("cleanDate", None),
            languages=request.form.get("languages", None),
            placeInferred=request.form.get("placeInferred", None),
            place=request.form.get("place", None),
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
            return render_template("pages/creer_edition.html", dates=dates)
    else:
        return render_template("pages/creer_edition.html", dates=dates)


@app.route("/modif_edition/<int:edition_id>", methods=["GET", "POST"])
def modif_edition(edition_id):
    """ Route permettant modifier le commentaire
        :param comment_id: Identifiant numérique du commentaire
        :return: page html avec un formulaire pour modifier le commentaire"""
    unique_edition = Edition.query.get(edition_id)

    if request.method=="POST":
        edition = Edition.query.get(edition_id)
        status, donnees = Edition.modif_edition(
            id=edition_id,
            short_title=request.form.get("short_title"),
            title_notes=request.form.get("title_notes"),
            uniform_title=request.form.get("uniform_title"),
            full_title=request.form.get("parallel_title"),
            author_first=request.form.get("author_first"),
            author_second=request.form.get("lien"),
            publisher=request.form.get("publisher"),
            prefaceur=request.form.get("prefaceur"),
            translator=request.form.get("translator"),
            nomRejete=request.form.get("nomRejete"),
            dateInferred=request.form.get("dateInferred"),
            displayDate=request.form.get("displayDate"),
            cleanDate=request.form.get("cleanDate"),
            languages=request.form.get("languages"),
            placeInferred=request.form.get("placeInferred"),
            place=request.form.get("place", None),
            place2=request.form.get("place2", None),
            placeClean=request.form.get("placeClean", None),
            country=request.form.get("country", None),
            format=request.form.get("format", None),
            formatNotes=request.form.get("formatNotes", None),
            imprint=request.form.get("imprint", None),
            signatures=request.form.get("sigantures", None),
            PpFf=request.form.get("PpFf", None),
            remarks=request.form.get("remarks", None),
            colophon=request.form.get("colophon", None),
            illustrated=request.form.get("illustrated", None),
            typographicMaterial=request.form.get("typographicMaterial", None),
            sheets=request.form.get("sheets", None),
            typeNotes=request.form.get("typeNotes", None),
            fb=request.form.get("fb", None),
            correct=request.form.get("correct", None),
            locFingerprints=request.form.get("locFingerprints", None),
            stcnFingerprints=request.form.get("stcnFingerprints", None),
            tpt=request.form.get("tpt", None),
            notes=request.form.get("notes", None),
            printer=request.form.get("printer", None),
            urlImage=request.form.get("urlImage"),
            class0=request.form.get("class0", None),
            class1=request.form.get("class1", None),
            class2=request.form.get("class2", None),
            digital=request.form.get("digital", None),
            fulltext=request.form.get("fulltext", None),
            tpimage=request.form.get("tpimage", None),
            privelege=request.form.get("privelege", None),
            dedication=request.form.get("dedication", None),
            reference=request.form.get("reference", None),
            citation=request.form.get("citation", None),
    )

        if status is True:
            flash('Merci de votre contribution', 'success')
            return redirect(url_for('issue', edition_id=edition.edition_id))

        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")

            return render_template("pages/modif_commentaire.html")
    return render_template("pages/modif_edition.html", nom="Erasmus", edition=unique_edition)

@app.route("/ajout_exemplaire/<int:identifier>", methods=["GET", "POST"])

def ajout_exemplaire(identifier):
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """

    if request.method == "GET":
        bibliotheques = Bibliothecae.query.all()
        edition = Edition.query.get(identifier)

        return render_template("pages/ajout_exemplaire.html", bibliotheques=bibliotheques, edition=edition)


    if request.method == "POST":
        edition = Edition.query.get(identifier)
        statut, donnees = Exemplaire.ajout_exemplaire(
            pressmark=request.form.get('pressmark'),
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
            return redirect(url_for('issue', edition_id=edition.edition_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_exemplaire.html")
    else:
        return render_template("pages/ajout_exemplaire.html")



@app.route("/modif_exemplaire/<int:exemplaire_id>", methods=["GET", "POST"])

def modif_exemplaire(exemplaire_id):
    """ Route gérant les ajouts des commentaires
        :return: page html d'ajout de commentaire
        """
    unique_exemplaire = Exemplaire.query.get(exemplaire_id)
    bibliotheques = Bibliothecae.query.all()
    if request.method == "POST":
        bibliotheques = Bibliothecae.query.all()
        exemplaire = Exemplaire.query.get(exemplaire_id)
        statut, donnees = Exemplaire.modif_exemplaire(
            id=exemplaire_id,
            pressmark=request.form.get('pressmark'),
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
            bibliothecae_id=request.form.get('library'),
        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('exemplar', exemplaire_id=exemplaire.exemplaire_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_exemplaire.html", bibliotheques=bibliotheques)
    else:
        return render_template("pages/modif_exemplaire.html", exemplaire=unique_exemplaire, bibliotheques=bibliotheques)



@app.route("/ajout_provenance/<int:exemplaire_id>", methods=["GET", "POST"])
def ajout_provenance(exemplaire_id):
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """

    if request.method == "GET":
        exemplaire = Exemplaire.query.get(exemplaire_id)

        return render_template("pages/ajout_provenance.html", exemplaire=exemplaire)

    if request.method == "POST":
        exemplaire = Exemplaire.query.get(exemplaire_id)
        statut, donnees = Provenance.ajout_provenance(

            exlibris=request.form.get('exlibris'),
            exdono=request.form.get('exdono'),
            envoi=request.form.get('envoi'),
            notesManuscrites=request.form.get('notesManuscrites'),
            armesPeintes=request.form.get('armesPeintes'),
            restitue=request.form.get('restitue'),
            mentionEntree=request.form.get('mentionEntree'),
            estampillesCachets=request.form.get('estampillesCachets'),
            possesseur=request.form.get('possesseur'),
            possesseur_formeRejetee=request.form.get('possesseur_formeRejetee'),
            reliure_provenance=request.form.get('reliure_provenance'),
            notes=request.form.get('notes'),
            exemplaire_id=exemplaire_id
    )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('exemplar', exemplaire_id=exemplaire.exemplaire_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_provenance.html", exemplaire=exemplaire)
    else:
        return render_template("pages/ajout_provenance.html")

@app.route("/modif_provenance/<int:provenance_id>", methods=["GET", "POST"])

def modif_provenance(provenance_id):

    unique_provenance = Provenance.query.get(provenance_id)

    if request.method == "POST":
        unique_provenance = Provenance.query.get(provenance_id)
        statut, donnees = Provenance.modif_provenance(

            id=provenance_id,
            exlibris=request.form.get('exlibris'),
            exdono=request.form.get('exdono'),
            envoi=request.form.get('envoi'),
            notesManuscrites=request.form.get('notesManuscrites'),
            armesPeintes=request.form.get('armesPeintes'),
            restitue=request.form.get('restitue'),
            mentionEntree=request.form.get('mentionEntree'),
            estampillesCachets=request.form.get('estampillesCachets'),
            possesseur=request.form.get('possesseur'),
            reliure_provenance=request.form.get('reliure_provenance'),
            possesseur_formeRejetee=request.form.get('possesseur_formeRejetee'),
            notes=request.form.get('notes'),
        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('exemplar', exemplaire_id=unique_provenance.provenance_exemplaire_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_provenance.html")
    else:
        return render_template("pages/modif_provenance.html", provenance=unique_provenance)

@app.route("/ajout_reference/<int:edition_id>", methods=["GET", "POST"])

def ajout_reference(edition_id):
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """

    if request.method == "GET":
        bibliographies = Bibliographie.query.all()
        edition = Edition.query.get(edition_id)

        return render_template("pages/ajout_reference.html", edition=edition, bibliographies=bibliographies)

    if request.method == "POST":
        edition = Edition.query.get(edition_id)
        statut, donnees = Reference.ajout_reference(

            volume=request.form.get('volume'),
            page=request.form.get('page'),
            recordNumber=request.form.get('recordNumber'),
            note=request.form.get('note'),
            bibliographie_id=request.form.get('oeuvre'),
            edition_id=edition_id
    )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('issue', edition_id=edition.edition_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_reference.html")
    else:
        return render_template("pages/ajout_reference.html")

@app.route("/modif_reference/<int:reference_id>", methods=["GET", "POST"])

def modif_reference(reference_id):
    bibliographies = Bibliographie.query.all()
    unique_reference = Reference.query.get(reference_id)

    if request.method == "POST":

        statut, donnees = Reference.modif_reference(

            id=reference_id,
            volume=request.form.get('volume'),
            page=request.form.get('page'),
            recordNumber=request.form.get('recordNumber'),
            note=request.form.get('note'),
            bibliographie_id=request.form.get('oeuvre')

        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('issue', edition_id=unique_reference.reference_edition_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_reference.html", bibliographies=bibliographies)
    else:
        return render_template("pages/modif_reference.html", reference=unique_reference, bibliographies=bibliographies)

@app.route("/ajout_citation/<int:edition_id>", methods=["GET", "POST"])

def ajout_citation(edition_id):
    """ Route gérant les ajouts des commentaires
    :return: page html d'ajout de commentaire
    """

    if request.method == "GET":
        edition = Edition.query.get(edition_id)

        return render_template("pages/ajout_citation.html", edition=edition)

    if request.method == "POST":
        edition = Edition.query.get(edition_id)
        statut, donnees = Citation.ajout_citation(

            dbname=request.form.get('dbname'),
            dbnumber=request.form.get('dbnumber'),
            url=request.form.get('url'),
            edition_id=edition_id
    )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('issue', edition_id=edition.edition_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/ajout_citation.html")
    else:
        return render_template("pages/ajout_citation.html")

@app.route("/modif_citation/<int:citation_id>", methods=["GET", "POST"])

def modif_citation(citation_id):

    unique_citation = Citation.query.get(citation_id)

    if request.method == "POST":

        statut, donnees = Citation.modif_citation(

            id=citation_id,
            dbname=request.form.get('dbname'),
            dbnumber=request.form.get('dbnumber'),
            url=request.form.get('url'),


        )
        if statut is True:
            flash("Enregistrement effectué", "success")
            return redirect(url_for('issue', edition_id=unique_citation.citation_edition_id))
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/modif_citation.html")
    else:
        return render_template("pages/modif_citation.html", citation=unique_citation)



@app.route("/recherche")
def recherche():
    """ Route permettant la recherche plein-texte
    """
    # On préfèrera l'utilisation de .get() ici
    #   qui nous permet d'éviter un if long (if "clef" in dictionnaire and dictonnaire["clef"])

    page = request.args.get("page", 1)

    if isinstance(page, str) and page.isdigit():
        page = int(page)
    else:
        page = 1

    # On crée une liste vide de résultat (qui restera vide par défaut
    #   si on n'a pas de mot clé)


    # On fait de même pour le titre de la page
    titre = "Recherche"
    resultats = Edition.recherche_avancee(request.args).paginate(page=page, per_page=EDITION_PAR_PAGE)



    return render_template(
        "pages/recherche.html",
        resultats=resultats,
        titre=titre,

    )


@app.route("/browse")
def browse():

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

@app.route("/suppression_edition/<int:edition_id>", methods=["GET", "POST"])
def suppression_edition(edition_id):
    """ Route pour supprimer le commentaire
    :param comment_id : identifiant numérique du commentaire
    :return: page html de suppression
    """

    unique_edition = Edition.query.get(edition_id)

    if request.method == "GET":
        return render_template("pages/suppr_edition.html", unique=unique_edition)
    else:
        status = Edition.delete_edition(edition_id=edition_id)
        if status is True :
            flash("Une édition a été supprimée !", "success")
            return redirect("/")
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('issue', edition_id=unique_edition.edition_id))

@app.route("/suppression_bibliographie/<int:bibliographie_id>", methods=["GET", "POST"])
def suppression_bibliographie(bibliographie_id):

    unique_bibliographie=Bibliographie.query.get(bibliographie_id)
    if request.method == "GET":
        return render_template("pages/suppression_bibliographie.html", bibliographie=unique_bibliographie)
    else:
        status = Bibliographie.delete_bibliographie(bibliographie_id=bibliographie_id)
        if status is True:
            flash("Une oeuvre a été supprimée !", "success")
            return redirect("/")
        else:
            flash("La suppression a échoué.", "danger")
            return redirect("/")

@app.route("/suppression_citation/<int:citation_id>", methods=["GET", "POST"])
def suppression_citation(citation_id):
    """ Route pour supprimer le commentaire
    :param comment_id : identifiant numérique du commentaire
    :return: page html de suppression
    """

    unique_citation = Citation.query.get(citation_id)

    if request.method == "GET":
        return render_template("pages/suppression_citation.html", citation=unique_citation)
    else:
        status = Citation.delete_citation(citation_id=citation_id)
        if status is True :
            flash("La citation a été supprimée !", "success")
            return redirect(url_for('issue', edition_id=unique_citation.citation_edition_id))
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('issue', edition_id=unique_citation.citation_edition_id))

@app.route("/suppression_bibliotheque/<string:bibliothecae_id>", methods=["GET", "POST"])
def suppression_bibliotheque(bibliothecae_id):

    unique_bibliotheque=Bibliothecae.query.get(bibliothecae_id)
    if request.method == "GET":
        return render_template("pages/suppression_bibliotheque.html", bibliotheque=unique_bibliotheque)
    else:
        status = Bibliothecae.delete_bibliotheque(bibliothecae_id=bibliothecae_id)
        if status is True:
            flash("Une oeuvre a été supprimée !", "success")
            return redirect("/")
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('library', bibliothecae_id=unique_bibliotheque.bibliothecae_id))

@app.route("/suppression_exemplaire/<int:exemplaire_id>", methods=["GET", "POST"])
def suppression_exemplaire(exemplaire_id):

    unique_exemplaire=Exemplaire.query.get(exemplaire_id)
    if request.method == "GET":
        return render_template("pages/suppression_exemplaire.html", exemplaire=unique_exemplaire)
    else:
        status = Exemplaire.delete_exemplaire(exemplaire_id=exemplaire_id)
        if status is True:
            flash("Un exemplaire a été supprimé !", "success")
            return redirect(url_for('issue', edition_id=unique_exemplaire.exemplaire_edition_id))
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('exemplar', exemplaire_id=unique_exemplaire.exemplaire_id))

@app.route("/suppression_provenance/<int:provenance_id>", methods=["GET", "POST"])
def suppression_provenance(provenance_id):

    unique_provenance=Provenance.query.get(provenance_id)
    if request.method == "GET":
        return render_template("pages/suppression_provenance.html", provenance=unique_provenance)
    else:
        status = Provenance.delete_provenance(provenance_id=provenance_id)
        if status is True:
            flash("Une provenance a été supprimée !", "success")
            return redirect(url_for('exemplar', exemplaire_id=unique_provenance.provenance_exemplaire_id))
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('exemplar', exemplaire_id=unique_provenance.provenance_exemplaire_id))

@app.route("/suppression_reference/<int:reference_id>", methods=["GET", "POST"])
def suppression_reference(reference_id):

    unique_reference=Reference.query.get(reference_id)
    if request.method == "GET":
        return render_template("pages/suppression_reference.html", reference=unique_reference)
    else:
        status = Reference.delete_reference(reference_id=reference_id)
        if status is True:
            flash("Une référence a été supprimée !", "success")
            return redirect(url_for('issue', edition_id=unique_reference.reference_edition_id))
        else:
            flash("La suppression a échoué.", "danger")
            return redirect(url_for('issue', edition_id=unique_reference.reference_edition_id))