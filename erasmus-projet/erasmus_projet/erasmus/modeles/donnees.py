from ..app import db



# On crée notre modèle
class Edition(db.Model):
    edition_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    edition_short_title = db.Column(db.Text)
    edition_title_notes = db.Column(db.Text)
    edition_full_title = db.Column(db.Text)
    edition_uniform_title = db.Column(db.Text)
    edition_author_first = db.Column(db.Text, nullable=False)
    edition_author_second = db.Column(db.Text)
    edition_publisher = db.Column(db.Text)
    edition_prefaceur = db.Column(db.Text)
    edition_nomRejete = db.Column(db.Text)
    edition_translator = db.Column(db.Text)
    edition_dateInferred = db.Column(db.Text)
    edition_displayDate = db.Column(db.Text)
    edition_cleanDate = db.Column(db.Text)
    edition_languages = db.Column(db.Text)
    edition_placeInferred = db.Column(db.Text)
    edition_place = db.Column(db.Text)
    edition_place2 = db.Column(db.Text)
    edition_placeClean = db.Column(db.Text)
    edition_country = db.Column(db.Text)
    edition_collator_format = db.Column(db.Text)
    edition_collator_formatNotes = db.Column(db.Text)
    edition_imprint = db.Column(db.Text)
    edition_collator_signatures = db.Column(db.Text)
    edition_collator_PpFf = db.Column(db.Text)
    edition_collator_remarks = db.Column(db.Text)
    edition_collator_colophon = db.Column(db.Text)
    edition_collator_illustrated = db.Column(db.Text)
    edition_collator_typographicMaterial  = db.Column(db.Text)
    edition_collator_sheets = db.Column(db.Text)
    edition_collator_typeNotes = db.Column(db.Text)
    edition_collator_fb = db.Column(db.Text)
    edition_collator_correct  = db.Column(db.Text)
    edition_collator_locFingerprints = db.Column(db.Text)
    edition_collator_stcnFingerprints = db.Column(db.Text)
    edition_collator_tpt = db.Column(db.Text)
    edition_notes = db.Column(db.Text)
    edition_printer = db.Column(db.Text)
    edition_urlImage = db.Column(db.Text)
    edition_class0 = db.Column(db.Text)
    edition_class1 = db.Column(db.Text)
    edition_class2 = db.Column(db.Text)
    edition_digital = db.Column(db.Text)
    edition_fulltext = db.Column(db.Text)
    edition_tpimage = db.Column(db.Text)
    edition_privelege = db.Column(db.Text)
    edition_dedication = db.Column(db.Text)
    edition_reference = db.Column(db.Text)
    edition_citation = db.Column(db.Integer)
    exemplaire = db.relationship("Exemplaire", back_populates="edition", lazy='dynamic')
    reference = db.relationship("Reference", back_populates="edition")
    citation = db.relationship("Citation", back_populates="edition")
    digital = db.relationship("Digital", back_populates="edition")


    def creer_edition(short_title, title_notes, uniform_title, full_title, author_first, author_second, publisher, prefaceur, nomRejete, translator, dateInferred, displayDate, cleanDate, languages, placeInferred, place, placeClean, place2, country, format, formatNotes, imprint, signatures, PpFf, remarks, colophon, illustrated, typographicMaterial, sheets, typeNotes, fb, correct, locFingerprints, stcnFingerprints, tpt, notes, printer, urlImage, class0, class1, class2, digital, fulltext, tpimage, privelege, dedication, reference, citation):
        erreurs = []
        if not short_title:
            erreurs.append("Le titre fourni est vide")
        if not author_first:
            erreurs.append("Le nom d'auteur fourni est vide")

        # Si on a au moins une erreur
        if len(erreurs) > 0:
            return False, erreurs

        # On crée un commentaire
        edition = Edition(
            edition_short_title=short_title,
            edition_title_notes=title_notes,
            edition_uniform_title=uniform_title,
            edition_full_title=full_title,
            edition_author_first=author_first,
            edition_author_second=author_second,
            edition_publisher=publisher,
            edition_prefaceur=prefaceur,
            edition_nomRejete=nomRejete,
            edition_translator=translator,
            edition_dateInferred=dateInferred,
            edition_displayDate=displayDate,
            edition_cleanDate=cleanDate,
            edition_languages=languages,
            edition_placeInferred=placeInferred,
            edition_place=place,
            edition_place2=place2,
            edition_placeClean=placeClean,
            edition_country=country,
            edition_collator_format=format,
            edition_collator_formatNotes=formatNotes,
            edition_imprint=imprint,
            edition_collator_signatures=signatures,
            edition_collator_PpFf=PpFf,
            edition_collator_remarks=remarks,
            edition_collator_colophon=colophon,
            edition_collator_illustrated=illustrated,
            edition_collator_typographicMaterial=typographicMaterial,
            edition_collator_sheets=sheets,
            edition_collator_typeNotes=typeNotes,
            edition_collator_fb=fb,
            edition_collator_correct=correct,
            edition_collator_locFingerprints=locFingerprints,
            edition_collator_stcnFingerprints=stcnFingerprints,
            edition_collator_tpt=tpt,
            edition_notes=notes,
            edition_printer=printer,
            edition_urlImage=urlImage,
            edition_class0=class0,
            edition_class1=class1,
            edition_class2=class2,
            edition_digital=digital,
            edition_fulltext=fulltext,
            edition_tpimage=tpimage,
            edition_privelege=privelege,
            edition_dedication=dedication,
            edition_reference=reference,
            edition_citation=citation,
            
        )
        print(edition)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(edition)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, edition
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_edition(id, short_title, title_notes, uniform_title, full_title, author_first, author_second, publisher, prefaceur, nomRejete, translator, dateInferred, displayDate, cleanDate, languages, placeInferred, place, placeClean, place2, country, format, formatNotes, imprint, signatures, PpFf, remarks, colophon, illustrated, typographicMaterial, sheets, typeNotes, fb, correct, locFingerprints, stcnFingerprints, tpt, notes, printer, urlImage, class0, class1, class2, digital, fulltext, tpimage, privelege, dedication, reference, citation):


        edition = Edition.query.get(id)

        edition.edition_short_title = short_title,
        edition.edition_title_notes = title_notes,
        edition.edition_uniform_title = uniform_title,
        edition.edition_full_title = full_title,
        edition.edition_author_first = author_first,
        edition.edition_author_second = author_second,
        edition.edition_publisher = publisher,
        edition.edition_prefaceur = prefaceur,
        edition.edition_nomRejete = nomRejete,
        edition.edition_translator = translator,
        edition.edition_dateInferred = dateInferred,
        edition.edition_displayDate = displayDate,
        edition.edition_cleanDate = cleanDate,
        edition.edition_languages = languages,
        edition.edition_placeInferred = placeInferred,
        edition.edition_place = place,
        edition.edition_place2 = place2,
        edition.edition_placeClean = placeClean,
        edition.edition_country = country,
        edition.edition_collator_format = format,
        edition.edition_collator_formatNotes = formatNotes,
        edition.edition_imprint = imprint,
        edition.edition_collator_signatures = signatures,
        edition.edition_collator_PpFf = PpFf,
        edition.edition_collator_remarks = remarks,
        edition.edition_collator_colophon = colophon,
        edition.edition_collator_illustrated = illustrated,
        edition.edition_collator_typographicMaterial = typographicMaterial,
        edition.edition_collator_sheets = sheets,
        edition.edition_collator_typeNotes = typeNotes,
        edition.edition_collator_fb = fb,
        edition.edition_collator_correct = correct,
        edition.edition_collator_locFingerprints = locFingerprints,
        edition.edition_collator_stcnFingerprints = stcnFingerprints,
        edition.edition_collator_tpt = tpt,
        edition.edition_notes = notes,
        edition.edition_printer = printer,
        edition.edition_urlImage = urlImage,
        edition.edition_class0 = class0,
        edition.edition_class1 = class1,
        edition.edition_class2 = class2,
        edition.edition_digital = digital,
        edition.edition_fulltext = fulltext,
        edition.edition_tpimage = tpimage,
        edition.edition_privelege = privelege,
        edition.edition_dedication = dedication,
        edition.edition_reference = reference,
        edition.edition_citation = citation,

        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(edition)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, edition
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def recherche_avancee(champs):
        """

        :param champs: Dictionaire de champs avec leurs valerurs
        :return:
        """
        champs = {
            clef: valeur
            for clef, valeur in champs.items()
            if valeur and len(valeur) > 0
        }

        filtres = []
        if "title" in champs:
            filtres.append(Edition.edition_short_title.like("%{}%".format(champs["title"])))
        if "auteur" in champs:
            filtres.append(Edition.edition_author_first.like("%{}%".format(champs["auteur"])))
        if "begin_date" in champs and "end_date" in champs:
            filtres.append(Edition.edition_cleanDate.between(champs["begin_date"], champs["end_date"]))

        return db.session.query(Edition).filter(
            db.and_(*filtres)  # db.and_(*[x==1, y==2])  # db.and_(x==1, y==2)
        )

    @staticmethod
    def delete_edition(edition_id):
        """
        Supprime un commentaire dans la base de données.
        :param comment_id_id : un identifiant d'un commentaire
        """

        edition = Edition.query.get(edition_id)

        try:

            db.session.delete(edition)
            db.session.commit()
            return True
        except Exception as failed:
            print(failed)
            return False






class Bibliothecae(db.Model):
    bibliothecae_id = db.Column(db.Text, unique=True, nullable=False, primary_key=True)
    bibliothecae_library = db.Column(db.Text)
    bibliothecae_adresse = db.Column(db.Text)
    bibliothecae_ville = db.Column(db.Text)
    bibliothecae_pays = db.Column(db.Text)
    bibliothecae_web = db.Column(db.Text)
    bibliothecae_weighting = db.Column(db.Text)
    exemplaire = db.relationship("Exemplaire", back_populates="bibliothecae")

    def ajout_bibliotheque(id, library, adresse, ville, pays, web, weighting):

        # On crée un commentaire
        bibliotheques = Bibliothecae(
            bibliothecae_id=id,
            bibliothecae_library=library,
            bibliothecae_web=web,
            bibliothecae_adresse=adresse,
            bibliothecae_ville=ville,
            bibliothecae_pays=pays,
            bibliothecae_weighting=weighting,

        )
        print(bibliotheques)
        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(bibliotheques)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, bibliotheques
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_bibliotheque(id, library, adresse, ville, pays, web, weighting):

        bibliotheques = Bibliothecae.query.get(id)

        bibliotheques.bibliothecae_library=library,
        bibliotheques.bibliothecae_web = web,
        bibliotheques.bibliothecae_adresse = adresse,
        bibliotheques.bibliothecae_ville = ville,
        bibliotheques.bibliothecae_pays = pays,
        bibliotheques.bibliothecae_weighting = weighting,


        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(bibliotheques)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, bibliotheques
        except Exception as erreur:
            return False, [str(erreur)]




class Exemplaire(db.Model):
    exemplaire_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    exemplaire_pressmark = db.Column(db.Text)
    exemplaire_hauteur = db.Column(db.Text)
    exemplaire_variantesEdition = db.Column(db.Text)
    exemplaire_digitalURL = db.Column(db.Text)
    exemplaire_notes = db.Column(db.Text)
    exemplaire_provenances = db.Column(db.Text)
    exemplaire_locFingerprint = db.Column(db.Text)
    exemplaire_stcnFingerprint = db.Column(db.Text)
    exemplaire_annotationManuscrite = db.Column(db.Text)
    exemplaire_collator_etatMateriel = db.Column(db.Text)
    exemplaire_collator_largeur = db.Column(db.Text)
    exemplaire_reliure_recueilFactice = db.Column(db.Text)
    exemplaire_reliure_reliure  = db.Column(db.Text)
    exemplaire_reliure_reliureXVI = db.Column(db.Text)
    exemplaire_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    exemplaire_bibliothecae_id = db.Column(db.Text, db.ForeignKey('bibliothecae.bibliothecae_id'))
    edition = db.relationship("Edition", back_populates="exemplaire")
    bibliothecae = db.relationship("Bibliothecae", back_populates="exemplaire")
    provenance = db.relationship("Provenance", back_populates="exemplaire")

    


    def ajout_exemplaire(pressmark, hauteur, variantesEdition, digitalURL, etatMateriel, notes, provenances, locFingerprint, stcnFingerprint, annotationManuscrite, largeur, recueilFactice, reliure, reliureXVI, edition_id, bibliothecae_id):

        # On crée un commentaire
        exemplars = Exemplaire(
            exemplaire_pressmark=pressmark,
            exemplaire_hauteur=hauteur,
            exemplaire_variantesEdition=variantesEdition,
            exemplaire_digitalURL=digitalURL,
            exemplaire_collator_etatMateriel=etatMateriel,
            exemplaire_notes=notes,
            exemplaire_provenances=provenances,
            exemplaire_locFingerprint=locFingerprint,
            exemplaire_stcnFingerprint=stcnFingerprint,
            exemplaire_annotationManuscrite=annotationManuscrite,
            exemplaire_collator_largeur=largeur,
            exemplaire_reliure_recueilFactice=recueilFactice,
            exemplaire_reliure_reliure=reliure,
            exemplaire_reliure_reliureXVI=reliureXVI,
            exemplaire_edition_id=edition_id,
            exemplaire_bibliothecae_id=bibliothecae_id
        )
        print(exemplars)
        try:
            # On l'ajoute au transport vers la base de données

            db.session.add(exemplars)
            # On envoie le paquet
            db.session.commit()


            # On renvoie le commentaire
            return True, exemplars
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_exemplaire(id, pressmark, hauteur, variantesEdition, digitalURL, etatMateriel, notes, provenances, locFingerprint, stcnFingerprint, annotationManuscrite, largeur, recueilFactice, reliure, reliureXVI, bibliothecae_id):

        exemplaires = Exemplaire.query.get(id)

        exemplaires.exemplaire_pressmark = pressmark,
        exemplaires.exemplaire_hauteur = hauteur,
        exemplaires.exemplaire_variantesEdition = variantesEdition,
        exemplaires.exemplaire_digitalURL = digitalURL,
        exemplaires.exemplaire_collator_etatMateriel = etatMateriel,
        exemplaires.exemplaire_notes = notes,
        exemplaires.exemplaire_provenances = provenances,
        exemplaires.exemplaire_locFingerprint = locFingerprint,
        exemplaires.exemplaire_stcnFingerprint = stcnFingerprint,
        exemplaires.exemplaire_annotationManuscrite = annotationManuscrite,
        exemplaires.exemplaire_collator_largeur = largeur,
        exemplaires.exemplaire_reliure_recueilFactice = recueilFactice,
        exemplaires.exemplaire_reliure_reliure = reliure,
        exemplaires.exemplaire_reliure_reliureXVI = reliureXVI,
        exemplaires.exemplaire_bibliothecae_id = bibliothecae_id

        try:
            # On l'ajoute au transport vers la base de données
            db.session.add(exemplaires)
            # On envoie le paquet
            db.session.commit()

            # On renvoie le commentaire
            return True, exemplaires
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def delete_exemplaire(exemplaire_id):
        """
        Supprime un commentaire dans la base de données.
        :param comment_id_id : un identifiant d'un commentaire
        """

        exemplaire = Exemplaire.query.get(exemplaire_id)

        try:

            db.session.delete(exemplaire)
            db.session.commit()
            return True
        except Exception as failed:
            print(failed)
            return False



    


class Reference(db.Model):
    reference_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    reference_volume = db.Column(db.Text)
    reference_page = db.Column(db.Text)
    reference_recordNumber = db.Column(db.Text)
    reference_note = db.Column(db.Text)
    reference_bibliographie_id = db.Column(db.Integer, db.ForeignKey('bibliographie.bibliographie_id'))
    reference_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="reference")
    bibliographie = db.relationship("Bibliographie", back_populates="reference")

    def ajout_reference(volume, page, recordNumber, note, bibliographie_id, edition_id):
        refs=Reference(

            reference_volume=volume,
            reference_page=page,
            reference_recordNumber=recordNumber,
            reference_note=note,
            reference_bibliographie_id=bibliographie_id,
            reference_edition_id=edition_id,

        )
        print(refs)
        try:
             db.session.add(refs)
             db.session.commit()

             return True, refs
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_reference(id, volume, page, recordNumber, note, bibliographie_id):

        references = Reference.query.get(id)
        references.reference_volume = volume,
        references.reference_page = page,
        references.reference_recordNumber = recordNumber,
        references.reference_note = note,
        references.reference_bibliographie_id = bibliographie_id,


        print(references)
        try:
            db.session.add(references)
            db.session.commit()

            return True, references

        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def delete_reference(reference_id):
        """
        Supprime un commentaire dans la base de données.
        :param comment_id_id : un identifiant d'un commentaire
        """

        reference = Reference.query.get(reference_id)

        try:

            db.session.delete(reference)
            db.session.commit()
            return True
        except Exception as failed:
            print(failed)
            return False


class Bibliographie(db.Model):
    bibliographie_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    bibliographie_code = db.Column(db.Text)
    bibliographie_author = db.Column(db.Text)
    bibliographie_bibliReference = db.Column(db.Text)
    bibliographie_title = db.Column(db.Text)
    bibliographie_imprint = db.Column(db.Text)
    bibliographie_URLLink = db.Column(db.Text)
    reference = db.relationship("Reference", back_populates="bibliographie")

    def ajout_bibliographie(code, author, bibliReference, title, imprint, urlLink):
        bibliographia=Bibliographie(
            bibliographie_code=code,
            bibliographie_author=author,
            bibliographie_bibliReference=bibliReference,
            bibliographie_title=title,
            bibliographie_imprint=imprint,
            bibliographie_URLLink=urlLink,
        )

        print(bibliographia)
        try:
            db.session.add(bibliographia)
            db.session.commit()

            return True, bibliographia
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_bibliographie(id, code, author, bibliReference, title, imprint, urlLink):

        bibliographies = Bibliographie.query.get(id)
        bibliographies.bibliographie_code = code,
        bibliographies.bibliographie_author = author,
        bibliographies.bibliographie_bibliReference = bibliReference,
        bibliographies.bibliographie_title = title,
        bibliographies.bibliographie_imprint = imprint,
        bibliographies.bibliographie_URLLink = urlLink,

        print(bibliographies)
        try:
            db.session.add(bibliographies)
            db.session.commit()

            return True, bibliographies

        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def delete_bibliographie(bibliographie_id):
        bibliographie = Bibliographie.query.get(bibliographie_id)

        try:
            db.session.delete(bibliographie)
            db.session.commit()
            return True

        except Exception as failed:
            print(failed)
            return False



class Citation(db.Model):
    citation_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    citation_dbname = db.Column(db.Text)
    citation_dbnumber = db.Column(db.Integer)
    citation_url = db.Column(db.Text)
    citation_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    edition = db.relationship("Edition", back_populates="citation")

    def ajout_citation(dbname, dbnumber, url, edition_id):
        citations=Citation(
            citation_dbname=dbname,
            citation_dbnumber=dbnumber,
            citation_url=url,
            citation_edition_id=edition_id
        )
        print(citations)
        try:
            db.session.add(citations)
            db.session.commit()

            return True, citations
        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def modif_citation(id, dbname, dbnumber, url):

        citations = Citation.query.get(id)
        citations.citation_dbname = dbname,
        citations.citation_dbnumber = dbnumber,
        citations.citation_url = url,

        print(citations)
        try:
            db.session.add(citations)
            db.session.commit()

            return True, citations

        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def delete_citation(citation_id):
        """
        Supprime un commentaire dans la base de données.
        :param comment_id_id : un identifiant d'un commentaire
        """

        citation = Citation.query.get(citation_id)

        try:

            db.session.delete(citation)
            db.session.commit()
            return True
        except Exception as failed:
            print(failed)
            return False


class Digital(db.Model):
    digital_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    digital_url = db.Column(db.Text)
    digital_provider = db.Column(db.Text, nullable=False)
    digital_edition_id = db.Column(db.Integer, db.ForeignKey('edition.edition_id'))
    digital_digitization_id = db.Column(db.Integer, db.ForeignKey('digitization.digitization_id'))
    edition = db.relationship("Edition", back_populates="digital")
    digitization = db.relationship("Digitization", back_populates="digital")

    def ajout_digital(url, provider):
        digitals=Digital(
           digital_url=url,
           digital_provider=provider
        )
        print(digitals)
        try:
            db.session.add(digitals)
            db.session.commit()

            return True, digitals
        except Exception as erreur:
            return False, [str(erreur)]



class Digitization(db.Model):
    digitization_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    digitization_provider = db.Column(db.Text)
    digitization_fullName = db.Column(db.Text)
    digitization_nationality = db.Column(db.Text)
    digitization_status = db.Column(db.Text)
    digitization_web = db.Column(db.Text)
    digitization_address = db.Column(db.Text)
    digitization_town = db.Column(db.Text)
    digitization_country = db.Column(db.Text)
    digitization_postcode = db.Column(db.Text)
    digitization_telephone = db.Column(db.Text)
    digitization_fax = db.Column(db.Text)
    digitization_email = db.Column(db.Text)
    digitization_notes = db.Column(db.Text)
    digital = db.relationship("Digital", back_populates="digitization")

    def ajout_digitazation(provider, fullName, nationality, status, web, address, town, country, postcode, telephone, fax, email, notes):
        digitizations=Digitization(
           digitization_provider = provider,
           digitization_fullName = fullName,
           digitization_nationality = nationality,
           digitization_status = status,
           digitization_web = web,
           digitization_address = address,
           digitization_town = town,
           digitization_country = country,
           digitization_postcode = postcode,
           digitization_telephone = telephone,
           digitization_fax = fax,
           digitization_email = email,
           digitization_notes = notes
        )
        print(digitizations)
        try:
            db.session.add(digitizations)
            db.session.commit()

            return True, digitizations
        except Exception as erreur:
            return False, [str(erreur)]


class Provenance(db.Model):
    provenance_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    provenance_exLibris = db.Column(db.Text)
    provenance_exDono = db.Column(db.Text)
    provenance_envoi = db.Column(db.Text)
    provenance_notesManuscrites = db.Column(db.Text)
    provenance_armesPeintes = db.Column(db.Text)
    provenance_restitue = db.Column(db.Text)
    provenance_mentionEntree = db.Column(db.Text)
    provenance_estampillesCachets = db.Column(db.Text)

    provenance_possesseur = db.Column(db.Text)
    provenance_possesseur_formeRejetee = db.Column(db.Text)
    provenance_notes = db.Column(db.Text)
    provenance_exemplaire_id = db.Column(db.Integer, db.ForeignKey('exemplaire.exemplaire_id'))
    exemplaire = db.relationship("Exemplaire", back_populates="provenance")

    def ajout_provenance(exlibris, exdono, envoi, notesManuscrites, armesPeintes, restitue, mentionEntree, estampillesCachets, possesseur, possesseur_formeRejetee, notes, exemplaire_id):
         provenances=Provenance(
             provenance_exLibris = exlibris,
             provenance_exDono = exdono,
             provenance_envoi = envoi,
             provenance_notesManuscrites = notesManuscrites,
             provenance_armesPeintes = armesPeintes,
             provenance_restitue = restitue,
             provenance_mentionEntree = mentionEntree,
             provenance_estampillesCachets = estampillesCachets,
             provenance_possesseur = possesseur,
             provenance_possesseur_formeRejetee = possesseur_formeRejetee,
             provenance_notes = notes,
             provenance_exemplaire_id = exemplaire_id

         )
         print(provenances)
         try:
             db.session.add(provenances)
             db.session.commit()

             return True, provenances

         except Exception as erreur:
             return False, [str(erreur)]

    @staticmethod
    def modif_provenance(id, exlibris, exdono, envoi, notesManuscrites, armesPeintes, restitue, mentionEntree, estampillesCachets, possesseur, possesseur_formeRejetee, notes):


        provenances = Provenance.query.get(id)


        provenances.provenance_exLibris = exlibris,
        provenances.provenance_exDono = exdono,
        provenances.provenance_envoi = envoi,
        provenances.provenance_notesManuscrites = notesManuscrites,
        provenances.provenance_armesPeintes = armesPeintes,
        provenances.provenance_restitue = restitue,
        provenances.provenance_mentionEntree = mentionEntree,
        provenances.provenance_estampillesCachets = estampillesCachets,

        provenances.provenance_possesseur = possesseur,
        provenances.provenance_possesseur_formeRejetee = possesseur_formeRejetee,
        provenances.provenance_notes = notes,


        print(provenances)
        try:
            db.session.add(provenances)
            db.session.commit()

            return True, provenances

        except Exception as erreur:
            return False, [str(erreur)]

    @staticmethod
    def delete_provenance(provenance_id):
        """
        Supprime un commentaire dans la base de données.
        :param comment_id_id : un identifiant d'un commentaire
        """

        provenance = Provenance.query.get(provenance_id)

        try:

            db.session.delete(provenance)
            db.session.commit()
            return True
        except Exception as failed:
            print(failed)
            return False



